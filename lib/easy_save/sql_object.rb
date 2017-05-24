require_relative 'db_connection'
require_relative 'associatable'
require_relative 'searchable'
require 'byebug'

require 'active_support/inflector'

class SQLObject
  extend Searchable
  extend Associatable

  def self.first_row
    sql = <<-SQL
    SELECT
      *
    FROM
      #{table_name}
    SQL

    @results ||= DBConnection.execute2(sql)
  end

  def self.columns
    self.first_row 
    @results.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) { attributes[col] }
      define_method("#{col}=") { |val| attributes[col] = val }
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    sql = <<-SQL
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    results = DBConnection.execute(sql)
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.inject([]) { |final, res|  final.push(new(res)) } 
  end

  def self.find(id)
    sql = <<-SQL
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL

    result = DBConnection.execute(sql, id).first
    result ? new(result) : nil
  end

  def self.first 
    sql = <<-SQL 
      SELECT 
        * 
      FROM 
        #{self.table_name}
    SQL
    result = DBConnection.execute(sql).first
    result ? new(result) : nil
  end



  def initialize(params = {})
    params.each do |attr_name, val|
      unless self.class.columns.include?(attr_name.to_sym)
        raise "unknown attribute '#{attr_name}'"
      end
      self.send("#{attr_name}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    @attributes.values
  end

  def insert
    col_names = self.class.columns.drop(1).join(", ")
    question_marks = (["?"] * (self.class.columns.length - 1)).join(", ")

    col_names = "(#{col_names})"
    question_marks = "(#{question_marks})"

    sql = <<-SQL
      INSERT INTO
        #{self.class.table_name} #{col_names}
      VALUES
        #{question_marks}
    SQL

    DBConnection.execute(sql, attribute_values)
    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_values = self.class.columns.map do |el|
      "#{el} = ?"
    end.join(', ')

    sql = <<-SQL
      UPDATE
        #{self.class.table_name}
      SET
        #{set_values}
      WHERE
        id = #{id}
    SQL

    DBConnection.execute(sql, *attribute_values)
  end

  def save
    id.nil? ? insert : update
  end
end

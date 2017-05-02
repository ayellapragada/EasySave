require_relative 'searchable'
require 'active_support/inflector'


class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end

  private 

  def set_initial_values(options)
    self.primary_key = options[:primary_key]
    self.class_name = options[:class_name].camelcase
    self.foreign_key = options[:foreign_key]
  end

end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    options[:class_name]  ||= name
    options[:primary_key] ||= :id
    options[:foreign_key] ||= "#{name.underscore}_id".to_sym

    set_initial_values(options)
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options[:class_name] ||= name.singularize
    options[:primary_key] ||= :id
    options[:foreign_key] ||= "#{self_class_name.underscore}_id".to_sym

    set_initial_values(options)
  end
end

module Associatable
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name.to_s, options)
    self.assoc_options[name] = options

    define_method(name) do
      fk_method = options.send(:foreign_key)
      fk_id = self.send(fk_method)

      class_name = options.class_name.constantize

      res = class_name.where(id: fk_id)
      res.first || nil
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self.to_s, options)

    define_method(name) do
      pk_id = self.id
      fk_id = options.send(:foreign_key)

      class_name = options.class_name.constantize
      class_name.where("#{fk_id}": pk_id)
    end
  end

  def assoc_options
    @assoc ||= {}
  end


  def has_one_through(name, through_name, source_name)

    define_method(name) do
      through_options = self.class.assoc_options[through_name] 
      source_options = through_options.model_class.assoc_options[source_name] 

      sql = <<-SQL
      SELECT
        #{source_options.table_name}.* 
      FROM
        #{through_options.table_name} 
      JOIN
        #{source_options.table_name} 
      ON
        #{through_options.table_name}.#{source_options.send(:foreign_key)} 
        = #{source_options.table_name}.#{source_options.send(:primary_key)} 
      WHERE
        #{through_options.table_name}.#{through_options.send(:primary_key)}
      SQL

      res = DBConnection.execute(sql)
      source_options.model_class.new(res.first)
    end
  end

end

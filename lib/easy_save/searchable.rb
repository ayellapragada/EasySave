require_relative 'db_connection'

module Searchable
  def where(params)

    where_line = params.keys.map do |key|
      "#{key} = ?"
    end.join(" AND ")

    sql = <<-SQL
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{where_line}
    SQL

    results = DBConnection.execute(sql, params.values)

    results.inject([]) { |final, res|  final.push(new(res)) } 
  end
end


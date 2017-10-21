require_relative 'db_connection'
require_relative '01_sql_object'
require 'byebug'
module Searchable
  def where(params)
    # ...
    # byebug
    where_str = ""
     i = 0
    params.each_pair do |k, v|
      where_str += "#{k} = ?"
      i += 1
      if i < params.length
        where_str += " AND "
      end

    end

    vals= params.values
    # byebug
    hits = DBConnection.execute(<<-SQL, *vals)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
      WHERE
        #{where_str}
    SQL
    # x.first
    arr = []
    hits.each do |hit|
      arr << find(hit['id'])
    end
    arr
    # [find(x.first[0])]
    # byebug
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end

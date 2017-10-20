require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  @@table_name = nil
  def self.columns
    # ...
    return @cols if @cols
    @cols = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
      #{table_name}
    SQL
    @cols = @cols[0].map { |colname| colname.to_sym }
  end

  def self.finalize!
    attribute = {}
    columns.each do |col|
      define_method(col) do
        instance_variable_get("@#{col}")
        attribute[col] = true
      end
      attribute[col] = true
      define_method("#{col.to_s}=".to_sym) do |arg|
        instance_variable_set("@#{col}", arg)
        attribute[col] = arg
      end
      # byebug
      # @attributes
    end

  end

  def self.table_name=(table_name)
    # ...
    @@table_name = table_name
  end

  def self.table_name
    # ...
    if @@table_name.nil?
      return (self.name.to_s.tableize)
    else
      return @@table_name
    end

  end

  def self.all
    # ...

  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
  end

  def attributes
    # ...
    return @attributes if @attributes
    @attributes = {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

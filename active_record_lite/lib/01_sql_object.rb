require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  # @@table_name = nil
  @@attributes = {}
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
    # attribute = {}
    # byebug
    # if @attributes.nil?
    #   @attributes = {}
    # end
    columns.each do |col|
      define_method(col) do
        # instance_variable_get("@#{col}")
        # @attributes[col]
        # attribute[col] = true
        attributes[col]
      end
      # attribute[col] = true
      define_method("#{col.to_s}=".to_sym) do |arg|
        # instance_variable_set("@#{col}", arg)
        attributes[col] = arg
        # @attributes[col] = arg
        # attribute[col] = arg
      end
    end
    # if !@attributes.nil? && !@attributes.empty?
    #   @attributes.keys do |key|
    #     define_method(key) do
    #       instance_variable_get("@#{col}")
    #     end
    #     define_method("#{key.to_s}=".to_sym) do |arg|
    #       instance_variable_set("@#{key}", arg)
    #     end
    #   end
    # end
    # unless @attributes.empty? do
    #   byebug
    # end
      # byebug
      # @attributesd
  end

  def self.getter_helper(instancevar)
    instance_variable_get("@#{col}")
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    if @table_name.nil?
      return (self.name.to_s.tableize)
    else
      return @table_name
    end

  end

  def self.all
    # ...
    rows = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    # byebug
    parse_all(rows)
  end

  def self.parse_all(results)
    # ...
    objects = []
    results.each do |params|
      # byebug
      objects << new(params)
    end
    objects
  end

  def self.find(id)
    # ...
    obj = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = ?
    SQL
    parse_all(obj).first
    # byebug
  end

  def name
    # byebug
  end

  def initialize(params = {})
    # ...
    # byebug
    params.each_pair do |k, v|
      raise "unknown attribute '#{k}'" unless self.class.columns.include?(k.to_sym)
      self.send("#{k}=".to_sym, v)
    end
  end

  def attributes
    # ...
    return @attributes if @attributes
    @attributes = {}
  end

  def attribute_values
    # ...
    @attributes.values
  end

  def insert
    # ...
    cols = self.class.columns[1..-1]
    cols.map!(&:to_s)
    col_names = cols.join(', ')
    # attrvalues =
    # x = map_attribute_vals_to_columns
    question_marks = Array.new(cols.length) {"?"}.join(', ')
    # byebug
    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
    # byebug
  end
  # def map_attribute_vals_to_columns
  #   attrs = attributes
  #
  #   cols = self.class.columns
  #   attribute_values.each do |attr_val|
  #
  #   end
  #   byebug
  # end

  def update
    # ...
    cols = self.class.columns[1..-1]
    cols.map!(&:to_s)
    col_names = cols.join(' = ?, ')
    col_names += " = ?"
    # my_id = self.id
    # byebug
    DBConnection.execute(<<-SQL, *attribute_values[1..-1], id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    if id.nil?
      insert
    else
      update
    end
  end
end

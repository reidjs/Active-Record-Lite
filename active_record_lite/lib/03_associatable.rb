require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    # ...
    @class_name.to_s.constantize
  end

  def table_name
    # ...
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
    snakename = name.underscore
    camelname = name.camelcase
    # byebug
    if !options[:foreign_key].nil?
      @foreign_key = options[:foreign_key]
    else
      @foreign_key = "#{snakename}_id".to_sym
    end

    if !options[:class_name].nil?
      @class_name = options[:class_name]
    else
      @class_name = camelname
    end

    if !options[:primary_key].nil?
      @primary_key = options[:primary_key]
    else
      @primary_key = :id
    end




  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
    if !options[:foreign_key].nil?
      @foreign_key = options[:foreign_key]
    else
      @foreign_key = "#{self_class_name.singularize.underscore}_id".to_sym
    end

    if !options[:primary_key].nil?
      @primary_key = options[:primary_key]
    else
      @primary_key = :id
    end

    if !options[:class_name].nil?
      @class_name = options[:class_name]
    else
      @class_name = name.camelcase.singularize
    end

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    # ...
    # define_method()

    byebug
    options = BelongsToOptions.new(name, options)
    byebug
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end

class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |instance_var_name|
      # define_method(:@name) do
      #   self.instance_variable_get(:@name)
      # end
      # define_method(:@name=) do |arg|
    #     dog.instance_variable_set(:@name, arg)
    #   end
      define_method("#{instance_var_name}".to_sym) do
        instance_variable_get("@#{instance_var_name}".to_sym)
      end
      define_method("#{instance_var_name}=".to_sym) do |arg|
        instance_variable_set("@#{instance_var_name}".to_sym, arg)
      end
    end
  end
end

def instance_var_name
  @instance_var_name
end

def instance_var_name=(arg)
  @instance_var_name=arg
end

class Dog
  def self.getter(instance_var_name)
    define_method("#{instance_var_name}".to_sym) do
      instance_variable_get("@#{instance_var_name}".to_sym)
    end
  end

  def self.setter(instance_var_name)
    define_method("#{instance_var_name}=".to_sym) do |arg|
      instance_variable_set("@#{instance_var_name}".to_sym, arg)
    end
  end
  getter :nick
  setter :nick
  def initialize
    @nick = 'doggy'
  end

end

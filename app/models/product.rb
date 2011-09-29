class Product < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_attributes, :extend => FindersByAttributeName

  # This code is run in AR::Base#initialize to populate the product_type_id
  # field just before setting the attributes.
  # Hooking here allow us to have access to the ProductType association, just
  # before the assignment of the attributes' values, so we can define our
  # dynamic setters
  def populate_with_current_scope_attributes
    super
    define_dynamic_accessors
  end

  def get_dynamic_attribute(name)
    product_attributes.with_name(name).value
  end

  def set_dynamic_attribute(name, value)
    attr_type = product_type.type_for(name)

    unless attr_type
      raise ActiveRecord::UnknownAttributeError, "no such attribute #{name}" 
    end

    attr = find_or_create_attribute(attr_type)

    attr.value = value
    product_attributes << attr
  end

  private
  
  def find_or_create_attribute(type)
    ProductAttribute.
      find_or_initialize_by_product_id_and_product_attribute_type_id(id, type.id)
  end

  def define_dynamic_accessors
    product_type.dynamic_attributes.each do |attr|
      define_dynamic_writer(attr.name)
      define_dynamic_reader(attr.name)
    end
  end

  def define_dynamic_writer(name)
    singleton_class.send(:define_method, "#{name}=".to_sym) do |value|
      set_dynamic_attribute(name, value)
    end
  end

  def define_dynamic_reader(name)
    singleton_class.send(:define_method, name) do
      get_dynamic_attribute(name)
    end
  end
end

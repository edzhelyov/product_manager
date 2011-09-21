class Product < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_attributes

  def attributes
    product_type.attributes
  end

  def get_attribute_value(name)
    attr = attribute_with_name(name)
    attr ? attr.value : nil
  end

  def set_attribute_value(name, value)
    attr_type = attribute_type_with_name(name)

    attr = ProductAttribute.
      find_or_create_by_product_id_and_product_attribute_type_id(id, attr_type.id)
    attr.value = value
    attr.save
    attr
  end

  def attribute_with_name(name)
    product_attributes.detect { |attr| attr.name == name.to_s }
  end

  def attribute_type_with_name(name)
    attributes.detect { |attr| attr.name == name.to_s }
  end

  def attribute_values(name)
    attr_type = attribute_type_with_name(name)
    attr_type.product_attribute_values
  end
end

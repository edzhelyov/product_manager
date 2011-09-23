class Product < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_attributes, :extend => FindersByAtrributeName

  def get_dynamic_attribute(name)
    product_attributes.with_name(name).value
  end

  def set_dynamic_attribute(name, value)
    attr_type = attribute_type_with_name(name)

    attr = ProductAttribute.
      find_or_create_by_product_id_and_product_attribute_type_id(id, attr_type.id)
    attr.value = value
    attr.save
    attr
  end
end

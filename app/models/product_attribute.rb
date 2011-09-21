class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute_type

  def name
    product_attribute_type.name
  end

  def value=(val)
    write_attribute(:value, type_cast(val))
  end

  def value
    type_cast(read_attribute(:value))
  end

  def type_cast(val)
    product_attribute_type.type_cast(val)
  end
end

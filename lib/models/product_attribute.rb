class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute_value

  def name
    product_attribute_value.name
  end

  def value
    product_attribute_value.value
  end
end

class ProductAttribute < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_attribute_type

  def name
    product_attribute_type.name
  end
end

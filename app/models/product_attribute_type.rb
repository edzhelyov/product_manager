class ProductAttributeType < ActiveRecord::Base
  has_many :product_attribute_values, :dependent => :destroy
end

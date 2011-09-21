class ProductAttributeType < ActiveRecord::Base
  has_many :product_attributes, :dependent => :destroy
end

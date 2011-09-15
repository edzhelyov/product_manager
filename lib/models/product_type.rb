class ProductType < ActiveRecord::Base
  has_many :products
  has_many :product_attribute_types

  def attribute(name)
    product_attribute_types.create :name => name
  end
  alias :add_attribute :attribute

  def remove_attribute(name)
    product_attribute_types.find_by_name(name).destroy
  end

  def attributes
    product_attribute_types.all
  end

  def attribute_names
    attributes.map(&:name)
  end
end

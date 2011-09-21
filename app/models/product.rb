class Product < ActiveRecord::Base
  belongs_to :product_type
  has_many :product_attributes

  def self.list
    ProductType.all
  end

  def self.define(name, &block)
    type = ProductType.create :name => name

    type.instance_exec(&block) if block_given?
    type
  end

  def attributes
    product_type.attributes
  end

  def get_attribute_value(name)
    attr = attribute_with_name(name)
    attr ? attr.value : nil
  end

  def set_attribute_value(name, value)
    attr_type = attribute_type_with_name(name)

    product_attributes.create :product_attribute_type => attr_type, :value => value
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

class ProductType < ActiveRecord::Base
  has_many :products
  has_many :product_attribute_types

  def self.define(name, &block)
    type = create(:name => name)

    type.instance_exec(&block) if block_given?
    type
  end

  def self.list
    all
  end

  def type_for(name)
    name = name.to_s
    product_attribute_types.detect { |x| x.name == name }
  end

  def add_attribute(name, type)
    product_attribute_types.create :name => name, :data_type => type
  end
  alias :has :add_attribute

  def remove_attribute(name)
    product_attribute_types.find_by_name(name).destroy
  end
end

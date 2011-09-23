class ProductType < ActiveRecord::Base
  has_many :products, :dependent => :destroy
  has_many :product_attribute_types, :dependent => :destroy

  def self.define(name, &block)
    type = create(:name => name)

    type.instance_exec(&block) if block_given?
    type
  end

  def self.list
    all
  end

  def dynamic_attributes
    product_attribute_types.all
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
    attr_type = product_attribute_types.find_by_name(name)
    if attr_type
      product_attribute_types.delete(attr_type)
      attr_type.destroy
    else
      raise ActiveRecord::UnknownAttributeError, "no such attribute #{name}"
    end
  end
end

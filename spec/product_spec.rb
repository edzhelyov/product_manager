require 'spec_helper'

describe Product do
  before :each do
    @pt = ProductType.define :Laptop do
      has :display, :integer
    end
  end

  let(:product) { @pt.products.create }
  let(:new_product) { @pt.products.build }

  describe '#get_dynamic_attribute' do
    it 'return nil if there is no value' do
      product.get_dynamic_attribute(:display).should be_nil
    end

    it 'read given attribute value and return type cast value' do
      attr_type = ProductAttributeType.find_by_name('display')
      product.product_attributes << ProductAttribute.new(:product_attribute_type => attr_type, :value => 15)

      product.get_dynamic_attribute(:display).should eq(15)
    end
  end

  describe '#set_dynamic_attribute' do
    it 'type cast the value before saving' do
      product.set_dynamic_attribute(:display, 'a')

      product.get_dynamic_attribute(:display).should eq(0)
    end

    it 'create the same attribute only once' do
      product.set_dynamic_attribute(:display, 10)
      product.set_dynamic_attribute(:display, 100.0)

      product.get_dynamic_attribute(:display).should eq (100)
      ProductAttribute.count.should eq (1)
    end

    it 'create dynamic attribute on new record' do
      new_product.set_dynamic_attribute(:display, 99.0)

      new_product.get_dynamic_attribute(:display).should eq(99)
      new_product.should be_new_record
    end

    it 'raise error on invalid attribute' do
      lambda {
        product.set_dynamic_attribute(:unknown, 10)
      }.should raise_error(ActiveRecord::UnknownAttributeError)
    end
  end

end

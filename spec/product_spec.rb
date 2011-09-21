require 'spec_helper'

describe Product do
  before :each do
    @pt = ProductType.define :Laptop do
      attribute :display, :integer
    end
  end

  let(:product) { @pt.products.create }

  describe '#set_attribute_value' do
    it 'type cast the value before saving' do
      product.set_attribute_value(:display, 'a')

      product.get_attribute_value(:display).should eq(0)
    end

    it 'create the same attribute only once' do
      product.set_attribute_value(:display, 10)
      product.set_attribute_value(:display, 100.0)

      product.get_attribute_value(:display).should eq (100)
      ProductAttribute.count.should eq (1)
    end
  end
end

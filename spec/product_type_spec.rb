require 'spec_helper'

describe ProductType do
  describe '.define' do
    it 'create new Product type with the suppplied attributes in the block' do
      ProductType.define :Laptop do
        has :ram, :string
      end

      ProductType.first.name.should eq 'Laptop'
      ProductAttributeType.first.name.should eq 'ram'
    end
  end

  describe '.list' do
    it 'return list of all available types' do
      ProductType.define :Laptop
      ProductType.define :Tablet

      ProductType.list.size.should eq 2
      ProductType.list.first.name.should eq 'Laptop'
      ProductType.list.last.name.should eq 'Tablet'
    end
  end

  describe '#remove_attribute' do
    let(:type) do
      ProductType.define :Laptop do
        has :ram, :string
      end
    end

    it 'remove the attribute when available' do
      type.product_attribute_types.size.should eq 1
    
      type.remove_attribute :ram

      type.product_attribute_types.size.should eq 0
    end

    it 'raises UnknownAttributeError when there is no such attribute' do
      lambda {
        type.remove_attribute :unknown
      }.should raise_error(ActiveRecord::UnknownAttributeError)
    end
  end
end

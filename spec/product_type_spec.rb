require 'spec_helper'

describe ProductType do
  describe '.define' do
    it 'create new Product type with the suppplied attributes in the block' do
      ProductType.define :Laptop do
        attribute :ram
      end

      ProductType.first.name.should eq 'Laptop'
      ProductAttributeType.first.name.should eq 'ram'
    end
  end
end

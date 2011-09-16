require 'spec_helper'

describe Product do
  before :each do
    Product.define :Laptop do
      attribute :ram
      attribute :os
    end
  end

  describe '#attributes' do
    let(:laptop) { Product.new(:product_type => ProductType.first, :price => 10.0) }

    it 'return all dynamic attributes for this product' do
      laptop.attributes.map(&:name).sort.should eq ['os', 'ram']
    end
  end
end

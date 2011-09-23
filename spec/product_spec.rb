require 'spec_helper'

describe Product do
  before :each do
    @pt = ProductType.define :Laptop do
      has :ram, :integer
    end
  end

  let(:product) { @pt.products.create }
  let(:new_product) { @pt.products.new }

  describe '#get_dynamic_attribute' do

    it 'return nil if there is no value' do
      product.get_dynamic_attribute(:ram).should be_nil
    end

    it 'read given attribute value and return type cast value' do
      attr_type = ProductAttributeType.find_by_name('ram')
      product.product_attributes << ProductAttribute.new(:product_attribute_type => attr_type, :value => 15)

      product.get_dynamic_attribute(:ram).should eq 15
    end

  end

  describe '#set_dynamic_attribute' do

    it 'type cast the value before saving' do
      product.set_dynamic_attribute(:ram, 'a')

      product.get_dynamic_attribute(:ram).should eq 0
    end

    it 'create the same attribute only once' do
      product.set_dynamic_attribute(:ram, 10)
      product.set_dynamic_attribute(:ram, 100.0)

      product.get_dynamic_attribute(:ram).should eq 100
      ProductAttribute.count.should eq 1
    end

    it 'create dynamic attribute on new record' do
      new_product.set_dynamic_attribute(:ram, 99.0)

      new_product.get_dynamic_attribute(:ram).should eq 99
      new_product.should be_new_record
    end

    it 'raise error on invalid attribute' do
      lambda {
        product.set_dynamic_attribute(:unknown, 10)
      }.should raise_error(ActiveRecord::UnknownAttributeError)
    end

  end

  context 'dynamic attributes' do
    before :each do
      @t = ProductType.define :Tablet do
        has :vendor, :string
      end
    end

    let(:tablet) { @t.products.new }

    it 'define attr_writer for the dynamic attributes' do
      product.ram = 15    

      product.get_dynamic_attribute(:ram).should eq 15
    end

    it 'define attr_reader for the dynamic attribute' do
      product.ram = 15    

      product.ram.should eq 15
    end

    it "defines the attributes only for the product's type" do 
      product.respond_to?(:ram).should be_true
      product.respond_to?(:vendor).should be_false

      tablet.respond_to?(:ram).should be_false
      tablet.respond_to?(:vendor).should be_true
    end

  end
end

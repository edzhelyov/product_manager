require 'spec_helper'

class ProductManager

  describe 'Create new product' do
    let(:class_path) { File.expand_path(__FILE__, '../classes') }
    let(:loader) { ClassLoader.new(class_path) }
    let(:manager) { ProductManager.new(loader, Builder) }
    let(:filename) { loader.filename(:laptop) }

    after :each do
      File.unlink(filename)
    end

    it 'save a class file of that product' do

      File.exists?(filename).should be_false

      manager.create :laptop do
        attribute :ram
      end

      content = File.read(filename)
      content.should match "class Laptop < ActiveRecord::Base"
    end
  end

end
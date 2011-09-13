require 'spec_helper'

describe ProductManager do
  describe '.create' do
    context 'called without block' do
      it 'create empty class definition with the given name' do
        ProductManager.create :laptop
        ProductManager::Laptop.should be_kind_of Object
      end
    end
  end
end

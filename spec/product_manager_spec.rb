require 'spec_helper'

class ProductManager

  describe ProductManager do
    describe '#create' do
      context 'called without block' do
        it 'create empty class definition with the given name' do
          loader = mock(ClassLoader)
          loader.should_receive(:load_class).with(:laptop)

          manager = ProductManager.new(loader)

          manager.create :laptop
        end
      end
    end
  end

end

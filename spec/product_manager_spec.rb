require 'spec_helper'

class ProductManager

  describe ProductManager do
    describe '#create' do
      context 'called without block' do
        it 'create empty class definition with the given name' do
          loader = mock(ClassLoader)
          builder = mock(Builder)
          Builder.stub(:new).and_return(builder)

          builder.should_receive(:class_definition).and_return('class definition')
          loader.should_receive(:save_class).with('class definition')

          manager = ProductManager.new(loader, Builder)

          manager.create :laptop
        end
      end

      context 'called with block' do
        it 'evaluate the block in the context of the newly created class' do
          loader = mock(ClassLoader)
          builder = mock(Builder)
          Builder.stub(:new).and_return(builder)

          builder.should_receive(:instance_exec)
          builder.should_receive(:class_definition).and_return('class definition')
          loader.should_receive(:save_class).with('class definition')

          manager = ProductManager.new(loader, Builder)

          manager.create :laptop do
            attribute :brand
            attribute :ram
          end
        end
      end
    end
  end

end

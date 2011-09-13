require 'spec_helper'

class ProductManager

  describe Builder do
    describe '#class_definition' do
      it 'return ActiveRecord::Base subclass based on the name given' do
        content = Builder.new(:laptop).class_definition

        content.should match "class Laptop < ActiveRecord::Base"
      end
    end

    describe '#initialize' do
      context 'with block given' do
        it 'evaluates the block into the context of self' do
          builder = Builder.new(:laptop) do
            attribute :ram
          end

          builder.attributes.should eq [:ram]
        end
      end
    end
  end

end

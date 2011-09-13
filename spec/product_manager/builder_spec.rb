require 'spec_helper'

class ProductManager

  describe Builder do
    describe '#class_definition' do
      it 'return ActiveRecord::Base subclass based on the name given' do
        content = Builder.new(:laptop).class_definition

        content.should match "class Laptop < ActiveRecord::Base"
      end
    end
  end

end

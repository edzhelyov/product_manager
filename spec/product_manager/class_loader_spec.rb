require 'spec_helper'

class ProductManager

  describe ClassLoader do
    context 'when created' do
      let(:existing_path) { File.dirname(__FILE__) }
      let(:non_existing_path) { File.dirname(__FILE__) + '/abracadabra/' }

      it 'require load path' do
        lambda {
          loader = ClassLoader.new(existing_path)
          loader.load_path.should eq existing_path
        }.should_not raise_error
        
        lambda {
          ClassLoader.new(non_existing_path)
        }.should raise_error(ClassLoader::NonexistingLoadPathError)
      end
    end
  end

end

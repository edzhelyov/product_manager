require 'spec_helper'

class ProductManager

  describe ClassLoader do
    let(:existing_path) { File.dirname(__FILE__) + '/classes/' }

    context 'when created' do
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

    describe '#load_class' do
      after :each do
        ProductManager.send(:remove_const, 'Laptop')
      end

      it 'load the class file if exists' do
        loader = ClassLoader.new(existing_path)

        ProductManager.const_defined?('Laptop').should be_false

        loader.load_class(:laptop)

        ProductManager.const_defined?('Laptop').should be_true
      end
    end

    describe '#save_class' do
      let(:filename) { existing_path + "test.rb" }

      after :each do
        File.unlink(filename)
      end

      it 'save file with the given content' do
        loader = ClassLoader.new(existing_path)

        File.exists?(filename).should be_false

        loader.save_class('test', 'Testing')
        
        content = File.read(filename).should eq 'Testing'
      end
    end
  end

end

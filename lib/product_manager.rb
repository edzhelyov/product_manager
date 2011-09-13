class ProductManager
  class << self
    def create(name, &block)
      create_class_files(name)
      load_class(name)
    end

    private
    
    def create_class_files(name)
      File.open("#{name}.rb", 'w+') do |f|
        f.write <<-EOS
class ProductManager
  class #{name.to_s.capitalize}
  end
end
        EOS
      end
    end

    def load_class(name)
      load "#{name}.rb"
    end
  end
end

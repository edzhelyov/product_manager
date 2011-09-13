class ProductManager
  class ClassLoader
    class NonexistingLoadPathError < StandardError; end

    attr_reader :load_path

    def initialize(load_path)
      raise NonexistingLoadPathError unless File.exists?(load_path)  

      @load_path = load_path
    end

    def load_class(name)
      load filename(name)
    end

    def save_class(name, content)
      File.open(filename(name), 'w+') do |f|
        f << content
      end
    end

    def filename(name)
      load_path + "#{name}.rb"
    end
  end
end

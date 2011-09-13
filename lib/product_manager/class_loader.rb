class ProductManager
  class ClassLoader
    class NonexistingLoadPathError < StandardError; end

    attr_reader :load_path

    def initialize(load_path)
      raise NonexistingLoadPathError unless File.exists?(load_path)  

      @load_path = load_path
    end

    def load_class(name)
      load load_path + "#{name}.rb"
    end
  end
end

require 'product_manager/class_loader'

class ProductManager
  def initialize(class_loader)
    @class_loader = class_loader
  end

  def create(name, &block)
    @class_loader.load_class(name)
#    create_class_files(name)
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
end

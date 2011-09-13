require 'product_manager/builder'
require 'product_manager/class_loader'

class ProductManager
  def initialize(class_loader, builder_class)
    @class_loader = class_loader
    @builder_class = builder_class
  end

  def create(name, &block)
    builder = @builder_class.new(name)
    builder.instance_exec(&block) if block_given?

    @class_loader.save_class(name, builder.class_definition)
#    @class_loader.load_class(name)
  end
end

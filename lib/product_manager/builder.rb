require 'active_record'

class ProductManager
  class Builder
    attr_reader :attributes

    def initialize(name, &block)
      @name = name
      @attributes = []

      instance_exec(&block) if block_given?
    end

    def attribute(name)
      @attributes << name
    end

    def class_definition
      str = <<-EOS
class #{@name.to_s.capitalize} < ActiveRecord::Base
end
      EOS

      str
    end
  end
end

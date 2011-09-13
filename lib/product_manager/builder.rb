require 'active_record'

class ProductManager
  class Builder
    def initialize(name)
      @name = name
      @attributes = []
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

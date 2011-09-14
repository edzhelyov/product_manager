require 'active_record'
require 'active_support/inflector'

class ProductManager
  class Builder
    attr_reader :attributes

    def initialize(name, &block)
      @name = name
      @attributes = []

      instance_exec(&block) if block_given?

      create_table
    end

    def attribute(name)
      @attributes << name
    end

    def create_table
     migration = Class.new(ActiveRecord::Migration)
     migration.class_eval <<-EOS
       def self.up
         create_table :#{@name.to_s.tableize} do |t|
           #{create_columns}
         end
       end
     EOS

     migration.verbose = false
     migration.migrate :up
    end

    def create_columns
      @attributes.map { |x| "t.string :#{x}" }.join("\n")
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

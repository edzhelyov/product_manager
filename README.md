# Introduction

ProductManager allow to create products with infinite number of attributes. You can add and remove attributes at any time.

# Usage

This is Rails engine and is currently targeting the 3.0 versions. Include the gem and run `rails g product_manager` this will
copy the migration file into db/migrate directory. 

The migration create the following tables:

* product_types
* product_attribute_types
* product_attributes
* products

The `products` table has two columns created by default `price` and `description`. You should edit the migration file if you
want to add or remove columns.

# API

* `ProductType.list` - returns list with available product types
* `ProductType.define(name, &block)` - creates a new product type and pass the block to it
* `ProductType.of_type(type_name)` - return scoped Product relation of the given type, which you can chain with #new, #create, etc

* `Product#get_dynamic_attribute(name)` - return the value of given attribute
* `Product#set_dynamic_attribute(name, value)` - set a value on given attribute

# Testing

A dummy rails app lives in spec/dummy and is used to test the engine agains
rails application.

`rake clean` will remove any migrations and data from the dummy app
`rake spec` will install the migrations, if needed and run the specs

# Examples

After you have this running, you can create new Product type with this code:

        laptop = ProductType.define :Laptop do
          has :ram, :integer
          has :display, :integer
          has :color, :string
        end

Then you can add additional attributes to that type:

      laptop.add_attribute(:os, :string)

or remove one:

    laptop.remove_attribute(:color)

Then create some products:

      l = laptop.products.create :price => 10.0, :description => 'Cheap laptop'
      l.set_dynamic_attribute(:ram, '1GB')
      l.set_dynamic_attribute(:display, 13)
      l.set_dynamic_attribute(:os, 'Windows 7')

# ActiveRecord's attributes interface

There is a attribute accessor for each dynamic attribute, making them work with
ActiveRecord's methods like #update_attributes, #new, #create, etc.

This way the example above can be rewritten as follows:

      l.ram = '1GB'
      l.display = 13
      l.os = 'Windows 7'

Or even better:

      params[:product] = {:ram => '1GB', :display => 13, :os => 'Windows 7'}
      l.update_attributes(params[:product])

# Application usage

Because every product require a type to work correctly you can manipulate products by two ways.
One is to work directly with the given ProductType:

      type = ProductType.find(type_id) || ProductType.find_by_name(type_name)
      type.products.create(params[:product])

The other is by using the .of_type proxy method on the Product class:

      product = Product.of_type(params[:type]).new 
      product.update_attributes(params[:product])

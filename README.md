# Introduction

ProductManager allow to create products with infinite number of attributes. You can add and remove attributes at any time.

# Usage

This is Rails engine and is currently targeting the 3.0 versions. Include the gem and run `rails g product_manager` this will
copy the migration file into db/migrate directory. 

The migration create the following tables:

* product_types
* product_attribute_types
* product_attribute_values
* product_attributes
* products

They are used to implement the EAV model that enable the dynamic attributes. You
should specify additional columns that you expect all of your products to share
into the create_table :products block.

All product manipulations are done through the Product object.

# API

* `Product.list` - returns list with available product types, currently this returns ProductType objects
* `Product.define` - creates a new product type and pass the block to the newly created product type object for execution.

* `Product#attributes` - return the attributes defined for this type
* `Product#get_attribute_value` - return the value of given attribute
* `Product#set_attribute_value` - set a value on given attribute

# Futher directions

There are two main functionalities:

* When you manipulate Product types and attirbutes, which we will call product metadata
* When you manipulate specific product instance

Manipulating Product types can be done with the .list method that return list of
all available types and manipulation of attributes with the actual ProductType object.

With a product instance you need to have list of the attributes, their values
and a way to set them.  Now I prefer to expose regular AR API for the dynamic 
attributes, so these operations are possible:

        laptop.ram = '1GB'
        laptop.update_attributes(:price => 10.0, :display => '19"')

# Testing

A dummy rails app lives in spec/dummy and is used to test the engine agains
rails application.

`rake clean` will remove any migrations and data from the dummy app
`rake spec` will install the migrations, if needed and run the specs

# Examples

After you have this running, you can create new Product type with this code:

        laptop = Product.define :Laptop do
          attribute :ram
          attribute :display
          attribute :color
        end

Then you can add additional attributes to that type:

      laptop.add_attribute(:os)

or remove one:

    laptop.remove_attribute(:color)

Then create some products:

      l = laptop.products.create :price => 10.0, :description => 'Cheap laptop'
      l.set_attribute_value(:ram, '1GB')
      l.set_attribute_value(:display, '13"')
      l.set_attribute_value(:os, 'Windows 7')

For now dynamically created attributes and the static ones defined on products table use different APIs for manipulation.
I will try to unify them, if that is possible.

# TODO

* Put all classes including the models into ProductManager namespace.
* Remove the product_attribute_values table, this simplify things up.
* Create module and encapsulate the methods for working with the dynamic
  attributes.
* Try wrap the AR standard interface to work the dynamic attributes too.
  Maybe with #method_missing or #define_method.

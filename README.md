# Introduction

ProductManager allow you to describe products and their attributes. Then it automatically handle the persistence part for you.

# Usage

Currently you have to execute the migration in lib/db/migrate to create the required tables and load the model files from lib/models. All this is setup if you go into the vendored_rails directory, run `rake db:migrate` there and you should be ready.

This will create the following tables:

* product_types
* product_attribute_types
* product_attribute_values
* product_attributes
* products

The whole idea is that you will need to operate only on the Product class, but this is not yet implemented, as I have to play with it before I find suitable API.

# API

Product.list - returns list with available product types, currently this returns ProductType objects
Product.define - creates a new product type and pass the block to the newly created product type object for execution.
Product.create - creates new product instance, a ProductType should be specified

Product#attributes - return the attributes defined for this type
Product#get_attribute_value - return the value of given attribute
Product#set_attribute_value - set a value on given attribute

# Futher directions

There are two main functionalities:

* When you manipulate Product types and attirbutes, which we will call product metadata
* When you manipulate specific product instance

Manipulating Product types can be done throught the .list method that return list of all available types and manipulation of attributes throught the actual ProductType object.

With a product instance you need to have list of the attributes, their values and a way to set them. Now I prefer to expose regular AR API for the dynamic attributes, so these operations are possible:

        laptop.ram = '1GB'
        laptop.update_attributes(:price => 10.0, :display => '19"')

But I haven't figure a way to do it, yet.

# Testing

This is intended to be used as engine or generator, but I don't know how to test it. It seems wise to seperate the logical and generation part
and test the logic separately from Rails.

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

# Introduction

ProductManager allow you to describe products and their attributes. Then it automatically handle the persistence part for you.
Creates the proper product schema and keep track of individual products.

# Usage

1. Describe product

      ProductManager.create :laptop do
        attribute :display, Integer
        attribute :os, String

        relation :ram, Integer
      end

Then you can access the laptop product by `ProductManager::Laptop` which is ActiveRecord class.

2. List available product

      ProductManager.list
      -> [Laptop, Tablet, TV ...]

This gives you the list of the available products

3. Product objects

The whole idea of this is to give you classes that represent products, so you can manipulate them further.
The current implementation is tight to ActiveRecord and the actual product class are ActiveRecord::Base subclasses.


NOTE: This is work in progress and the API could change.

# Dependencies

* ActiveRecord 3.0

Testing:

* Rspec
* Sqlite3

# Current status

ProductManager needs two classes to work, a ClassLoader that save/load the corresponding AR::Base classes and
Buidler that wraps the AR::Migration and is responsible for the table creation.

# TODO

* Automatically load classes
* Wrap different column type into `attribute`
* Add relation that creates related table and foreign key
* Define interface for manipulating the related data
* Define an API that all builders should implement - attribute, relation, etc
* Add configuration, so the public API is much simpler, no need to know Loader and Builder class
* Implement EAV backend

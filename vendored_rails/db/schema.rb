# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110915151313) do

  create_table "product_attribute_types", :force => true do |t|
    t.integer "product_type_id"
    t.string  "name"
  end

  create_table "product_attribute_values", :force => true do |t|
    t.integer "product_attribute_type_id"
    t.string  "value"
  end

  create_table "product_attributes", :force => true do |t|
    t.integer "product_id"
    t.integer "product_attribute_value_id"
  end

  create_table "product_types", :force => true do |t|
    t.string "name"
  end

  create_table "products", :force => true do |t|
    t.integer "product_type_id"
    t.decimal "price"
    t.string  "description"
  end

end

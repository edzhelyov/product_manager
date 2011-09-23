class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :product_types do |t|
      t.string :name
    end

    create_table :products do |t|
      t.integer :product_type_id
      t.decimal :price
      t.string :description
    end

    create_table :product_attribute_types do |t|
      t.integer :product_type_id
      t.string :name
      t.string :data_type
    end

    create_table :product_attributes do |t|
      t.integer :product_id
      t.integer :product_attribute_type_id
      t.string  :value
    end
  end

  def self.down
    drop_table :product_attributes
    drop_table :product_attribute_types
    drop_table :product
    drop_table :product_types
  end
end

# To update this table, I need a primary key.
# I need a fake id acting as primary key.
# create_join_table doesn't create a primary key.

class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    #create_join_table :lists, :products, table_name: :items do |t|

      t.integer :quantity, null: false, default: 1
      t.boolean :collected, null: false, default: false
      t.string  :notes, null: true, default: ''

      t.belongs_to :list, index: true
      t.belongs_to :product, index: true

      t.timestamps null: false

    end
    add_index :items, [ :list_id, :product_id ], unique: true
  end
end

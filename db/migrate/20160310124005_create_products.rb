class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|

      t.string :name, null: false, default: ""

      t.belongs_to :user, index: true

      t.timestamps null: false
    end

    add_index :products, [ :name, :user_id ],             unique: true
  end
end

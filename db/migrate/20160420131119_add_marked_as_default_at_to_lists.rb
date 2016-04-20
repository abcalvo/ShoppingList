class AddMarkedAsDefaultAtToLists < ActiveRecord::Migration
  def change
    add_column :lists, :marked_as_default_at, :datetime, null: false, default: Time.now
  end
end

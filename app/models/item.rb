class Item < ActiveRecord::Base
  belongs_to :list
  belongs_to :product

  def self.create_or_update_item(list, product, quantity, notes)
    if (Item.where(list: list, product: product).count == 0)
      create_item(list, product, quantity, notes)
    else
      update_item(list, product, quantity, notes)
    end
  end

  def self.destroy_item(list, product)
    Item.where(list: list, product: product).first.destroy
  end

  def self.toggle_collected(list, product)
    item = Item.where(list: list, product: product)

    if (item.count == 1)
      item.first.collected = ! item.first.collected
    end

    return item.first
  end

  private
  def self.create_item(list, product, quantity, notes)
    item = Item.new

    item.list = list
    item.product = product
    item.quantity = quantity
    item.notes = notes

    return item
  end

  def self.update_item(list, product, quantity, notes)
    item = Item.where(list: list, product: product).first

    item.quantity = quantity
    item.notes = notes

    return item
  end
end

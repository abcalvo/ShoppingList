class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, -> { joins(:product).order('products.name ASC') }

  def self.create_new_list(list_params, owner)
    list = List.new(list_params)

    list.user = owner

    return list
  end
end

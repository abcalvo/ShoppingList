class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, -> { joins(:product).order('products.name ASC') }

  def self.create_new_list(list_params, owner)
    list = List.new(list_params)

    list.user = owner
    list.marked_as_default_at = Time.new

    return list
  end
end

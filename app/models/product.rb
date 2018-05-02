class Product < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def self.create_new_product(product_params, owner)
    product = Product.new(product_params)

    product.name.strip!
    product.user = owner
    product.deleted = false

    return product
  end
end

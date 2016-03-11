class Product < ActiveRecord::Base
  belongs_to :user
  has_many :items

  def self.create_new_product(product_params, owner)
    product = Product.new(product_params)

    product.user = owner

    return product
  end
end

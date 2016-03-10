class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @products = current_user.products.order(name: :asc)
  end

  def new
  end

  def create
    @product = Product.create_new_product(product_params, current_user)

    if @product.save
      redirect_to product_path(@product)
    else
      flash.now[:warning] = 'Error creando nuevo producto'
      render 'new'
    end
  end

  def show
    @product = current_user.products.find_by_id(params[:id])
  end

  private
  def product_params
    params.require(:product).permit(:name)
  end
end

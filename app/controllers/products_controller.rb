class ProductsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @products = current_user.products.where(deleted: false).order(name: :asc)
  end

  def new
    @from_edit = params.has_key?(:from_edit)
    @list = params[:list] || -1
  end

  def create
    @product = Product.create_new_product(product_params, current_user)

    if @product.save
      if (params[:product][:from_edit] == 'true')
        redirect_to edit_list_path(params[:product][:list])
      else
        redirect_to products_path
      end
    else
      flash.now[:warning] = 'Error creando nuevo producto'
      render 'new'
    end
  end

  def show
    @product = current_user.products.find_by_id(params[:id])
  end

  def edit
    @product = current_user.products.find_by_id(params[:id])
  end

  def update
    @product = current_user.products.find_by_id(params[:id])

    if @product.update(product_params)

      redirect_to products_path
    else
      flash.now[:warning] = 'Error actualizando producto'
      render 'edit'
    end

  end

  def destroy
    @product = current_user.products.find_by_id(params[:id])
    @product.deleted = true


    if @product.save
      redirect_to products_path
    else
      flash.now[:warning] = 'Error borrando producto'
      render 'edit'
    end
  end

  private
  def product_params
    params.require(:product).permit(:name)
  end
end

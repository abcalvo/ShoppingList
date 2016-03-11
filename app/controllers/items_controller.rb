class ItemsController < ApplicationController
  def create
    list = List.find_by_id(params[:list_id])
    product = Product.find_by_id(params[:product_id])
    quantity = params[:quantity]
    notes = params[:notes]

    @item = Item.create_or_update_item(list, product, quantity, notes)

    if @item.save
      respond_to do |format|
        format.html { redirect_to list_path(list) }
        format.json { render json: {status: 'ok'} }
      end
    else
      respond_to do |format|
        format.html { flash.now[:warning] = 'Error añadiendo artículo a la lista de la compra'
          redirect_to list_path(list) }
        format.json { render json: {status: 'error', message: 'Error añadiendo artículo a la lista de la compra'} }
      end

    end
  end

  def destroy
    puts params

    list = List.find_by_id(params[:list_id])
    product = Product.find_by_id(params[:product_id])

    if Item.destroy_item(list, product)
      respond_to do |format|
        format.html { redirect_to list_path(list) }
        format.json { render json: {status: 'ok'} }
      end
    else
      respond_to do |format|
        format.html { redirect_to list_path(list) }
        format.json { render json: {status: 'error'} }
      end
    end
  end

  def mark_as_collected
    list = List.find_by_id(params[:list_id])
    product = Product.find_by_id(params[:product_id])

    @item = Item.toggle_collected(list, product)

    if @item.save
      respond_to do |format|
        format.html { redirect_to list_path(list) }
        format.json { render json: {status: 'ok'} }
      end
    else
      respond_to do |format|
        format.html { flash.now[:warning] = 'Error marcando artículo como cogido'
          redirect_to list_path(list) }
        format.json { render json: {status: 'error', message: 'Error marcando artículo como cogido'} }
      end

    end
  end
end

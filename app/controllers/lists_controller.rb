class ListsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @lists = current_user.lists.order(created_at: :desc)
  end

  def new
    @default_list_name = 'Lista de la compra día ' +
      Time.new.strftime('%d/%m/%Y')
  end

  def edit
    @list = current_user.lists.find_by_id(params[:id])
    @products = current_user.products.where(deleted: false).order(name: :asc)
  end

  def edit_name
    @list = current_user.lists.find_by_id(params[:id])
  end

  def update_name
    @list = current_user.lists.find_by_id(params[:id])

    @list.name = list_params[:name]

    if @list.save
      redirect_to list_path(@list)
    else
      flash.now[:warning] = 'Error creando nueva lista de la compra'
      render 'new'
    end
  end

  def mark_as_default
    @list = current_user.lists.find_by_id(params[:id])

    @list.marked_as_default_at = Time.now

    if @list.save
      flash[:info] = 'Marcada lista de la compra como lista por defecto'
      redirect_to edit_list_path(@list)
    else
      flash.now[:warning] = 'Error al marcar lista de la compra como lista por defecto'
      redirect_to edit_list_path(@list)
    end
  end

  def create
    @list = List.create_new_list(list_params, current_user)

    if @list.save
      redirect_to list_path(@list)
    else
      flash.now[:warning] = 'Error creando nueva lista de la compra'
      render 'new'
    end
  end

  def show
    @list = current_user.lists.find_by_id(params[:id])
  end

  private
  def list_params
    params.require(:list).permit(:name)
  end

end

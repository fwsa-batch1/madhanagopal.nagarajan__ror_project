class MenuItemsController < ApplicationController
  before_action :is_admin
  before_action :set_menu_item, only: [:edit, :update, :destroy]

  def new
  end

  def create
    menu_category_id = params[:menu_category_id]
    menu_item = MenuItem.new(name: params[:name], description: params[:description], price: params[:price])
    if menu_item.save
      MenuCategoryItem.create(menu_item_id: menu_item.id, menu_category_id: menu_category_id)
      redirect_to new_menu_category_item_path(menu_category_id: menu_category_id)
    else
      flash["menu-item-error"] = menu_item.errors.full_messages.join(", ")
      redirect_to new_menu_item_path(menu_category_id: menu_category_id)
    end
  end

  def update
    if params[:name]
      @menu_item.update(name: params[:name], description: params[:description], price: params[:price])
    else
      @menu_item.update(status: params[:status])
    end
    redirect_to root_path
  end

  def destroy
    @menu_item.destroy
    redirect_to root_path
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end
end

class ItemsController < ApplicationController
  def index
    @items = Item.all
    if params[:search]
      @items = Item.search(params[:search])
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def deal
    @featured_car = Item.find_by(name: 'gnar possum')
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :brand, :price, :category_id, :image)
  end
end

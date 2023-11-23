class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render 'new'
    end
  end

  def show
    @genres = Genre.all
  end

  def update
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render 'edit'
    end
  end

  def edit

  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :tax_included_price, :image, :is_saled, :genre_id)
  end

  def set_item
    @item = Item.find(params[:id]) unless params[:id] == "edit"# "params[:id]"が"edit"でない場合にのみアイテムを検索する。
  end
end

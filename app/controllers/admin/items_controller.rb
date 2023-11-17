class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
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
    params.require(:item).permit(:name, :introduction, :tax_included_price, :image)
  end

  def ensure_current_user  # 選択したitemのユーザー情報とログインしているユーザー情報が違う場合は編集できませんよーっ。
    item = Item.find(params[:id])
    if item.user_id != current_user.id
      redirect_to action: :index
    end
  end
  def set_item
    @item = Item.find(params[:id])
  end
end

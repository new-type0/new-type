class Public::ItemsController < ApplicationController
  def index
    @items, @sort = get_items(params)
  end

  def show
  end
  def get_items(params)
    return Item.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    return Item.latest, 'latest' if params[:latest]

    return Item.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]

    return Item.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
  end
end

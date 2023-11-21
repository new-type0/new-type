class Public::ItemsController < ApplicationController
  def index
    @items, @sort = get_items(params)
    @items = Item.all
    @genres = Genre.all
    if params[:genre_id].present?
      #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    end
  end

  def show
    @item = Item.find(params[:id])
    @cart_items = CartItem.new
    @genres = Genre.all
    if params[:genre_id].present?
      #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items
    end
  end

  def get_items(params)
    return Item.all, 'default' unless params[:latest] || params[:price_high_to_low] || params[:price_low_to_high]

    return Item.latest, 'latest' if params[:latest]

    return Item.price_high_to_low, 'price_high_to_low' if params[:price_high_to_low]

    return Item.price_low_to_high, 'price_low_to_high' if params[:price_low_to_high]
  end


end

class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def sum_of_price
  return 0 if item.nil? || amount.nil?
    item.tax_included_price.to_i * amount
  end

end

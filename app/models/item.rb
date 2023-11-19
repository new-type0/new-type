class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :tax_included_price
    validates :image
  end

  has_one_attached :image
  scope :price_high_to_low, -> { order(price: :desc) }
  scope :price_low_to_high, -> { order(price: :asc) }

  belongs_to :genre
  
  has_many :order_details
  has_many :orders, through: :order_details
  
  def remove_tax_price
    (self.tax_include_price/1.10).round
  end
  
end

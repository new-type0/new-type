class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :tax_included_price
    validates :image
  end
  
  validates :genre_id, presence: true, unless: -> { genre_id.blank? }

  has_one_attached :image
  scope :price_high_to_low, -> { order(tax_included_price: :desc) }
  scope :price_low_to_high, -> { order(tax_included_price: :asc) }

  belongs_to :genre

  has_many :order_details
  has_many :orders, through: :order_details
  has_many :cart_items, dependent: :destroy

  def add_tax_price
    (self.tax_included_price*1.10).round
  end

end

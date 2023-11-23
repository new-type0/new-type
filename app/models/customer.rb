class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :addresses
  has_many :orders
  has_many :cart_items
  has_many :oders
  has_many :addresses

  enum is_active: {active: true, non_active: false}

  has_many :cart_items, dependent: :destroy

end

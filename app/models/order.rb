class Order < ApplicationRecord

  # Orderモデルに仮想的な属性としてattr_accessorを使用してaddress_optionを追加
  attr_accessor :address_option

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum payment_method: {credit_card: 0, transfer: 1}
  enum order_status: {waiting_for_payment: 0, payment_confirmation: 1, production: 2, prepairing: 3, sent: 4 }
end

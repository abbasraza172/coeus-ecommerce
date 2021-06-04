class Order < ApplicationRecord
  #belongs to associations
  belongs_to :user

  #has many associations
  has_many :order_products
  has_many :products, through: :order_products

  #enum for status
  enum status: { pending: 0, accepted: 1, failed: 2, processing: 3, canceled: 4, delivered: 5 }
end

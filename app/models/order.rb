class Order < ApplicationRecord
  belongs_to :user
  has_many :products, through: :order_products
  enum status: { pending: 0, accepted: 1, failed: 2, processing: 3, canceled: 4, delivered: 5 }
end

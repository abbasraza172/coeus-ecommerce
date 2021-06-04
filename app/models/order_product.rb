class OrderProduct < ApplicationRecord
  #belongs to associations
  belongs_to :order
  belongs_to :product

  #validations
  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true, numericality: true
  validates :price, presence: true, numericality: true
end

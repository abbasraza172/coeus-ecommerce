class Business < ApplicationRecord
  #has many associations
  has_many :users
  has_many :feedbacks, as: :reviewable
  has_many :pictures, as: :imageable
  has_many :products, dependent: :destroy
  has_many :order_products, through: :products
  has_many :orders, through: :order_products

  #validations
  validates :name, presence: true
end

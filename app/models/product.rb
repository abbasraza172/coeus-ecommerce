class Product < ApplicationRecord
  # belongs to association
  belongs_to :business

  # has many associations
  has_many :pictures, as: :imageable
  has_many :categories, through: :product_categories
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :feedbacks, as: :reviewable

  #validation
  validates :name, presence: true
  validates :email, uniqueness: true
  validates :current_price, numericality: true
  validates :quantity, numericality: true
end

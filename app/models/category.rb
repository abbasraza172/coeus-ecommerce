class Category < ApplicationRecord
  # has many association
  has_many :product_categories, inverse_of: :category
  has_many :products, through: :product_categories

  #validations
  validates :name, presence: true
end

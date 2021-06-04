class Category < ApplicationRecord
  # has many association
  has_many :products, through: :product_categories

  #validations
  validates :name, presence: true
end

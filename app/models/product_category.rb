class ProductCategory < ApplicationRecord
  #belongs to associations
  belongs_to :product
  belongs_to :category

  #validations
  validates :category_id, presence: true
end

class Category < ApplicationRecord
    # has many association
    has_many :product_categories
    has_many :products, through: :product_categories
end

class Category < ApplicationRecord
    # has many association
    has_many :products, through: :product_categories
end

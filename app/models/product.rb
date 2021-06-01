class Product < ApplicationRecord
    belongs_to :user
    validates :name, presence: true

    has_many :pictures, as: :imageable

    has_many :categories, through: :product_categories

    has_many :orders, through: :order_products

    has_many :feedbacks, as: :reviewable
end

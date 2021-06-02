class Product < ApplicationRecord
    # belongs to association
    belongs_to :user

    # has many associations 
    has_many :pictures, as: :imageable
    has_many :categories, through: :product_categories
    has_many :orders, through: :order_products
    has_many :feedbacks, as: :reviewable

    #validation
    validates :name, presence: true
end

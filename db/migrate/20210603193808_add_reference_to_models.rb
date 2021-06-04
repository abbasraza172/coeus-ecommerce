class AddReferenceToModels < ActiveRecord::Migration[6.1]
  def up
    add_reference :users, :business
    add_reference :products, :business, null: false
    remove_column :products, :user_id

    change_column_default :products, :status, true
    change_column_default :categories, :status, true
    change_column_default :feedbacks, :status, true
    change_column_default :users, :status, true
    change_column_default :orders, :status, 0

    change_column :products, :description, :text
    change_column :products, :current_price, :float
    change_column :orders, :total_bill, :float
    change_column :order_products, :price, :float
    change_column :feedbacks, :review, :text
    change_column :orders, :status, :integer

    change_column_null :feedbacks, :stars, false
    change_column_null :pictures, :name, false
    change_column_null :pictures, :imageable_type, false
    change_column_null :pictures, :imageable_id, false
    change_column_null :order_products, :order_id, false
    change_column_null :order_products, :product_id, false
    change_column_null :order_products, :quantity, false
    change_column_null :order_products, :price, false
    change_column_null :product_categories, :category_id, false
    change_column_null :product_categories, :product_id, false
    change_column_null :orders, :status, false
    change_column_null :orders, :delivery_address, false
    change_column_null :orders, :total_bill, false
    change_column_null :products, :name, false
    change_column_null :products, :current_price, false
    change_column_null :products, :quantity, false
    change_column_null :products, :status, false
    change_column_null :feedbacks, :status, false
    change_column_null :feedbacks, :reviewable_type, false
    change_column_null :feedbacks, :reviewable_id, false
    change_column_null :businesses, :name, false
    change_column_null :businesses, :status, false
  end

  def down
    remove_column :users, :business_id
    remove_column :products, :business_id
    add_reference :products, :user

    change_column_default :products, :status, nil
    change_column_default :categories, :status, nil
    change_column_default :feedbacks, :status, nil
    change_column_default :users, :status, nil
    change_column_default :orders, :status, nil

    change_column :products, :description, :string
    change_column :products, :current_price, :int
    change_column :orders, :total_bill, :int
    change_column :order_products, :price, :int
    change_column :feedbacks, :review, :string
    change_column :orders, :status, :string

    change_column_null :feedbacks, :stars, true
    change_column_null :pictures, :name, true
    change_column_null :pictures, :imageable_type, true
    change_column_null :pictures, :imageable_id, true
    change_column_null :order_products, :order_id, true
    change_column_null :order_products, :product_id, true
    change_column_null :order_products, :quantity, true
    change_column_null :order_products, :price, true
    change_column_null :product_categories, :category_id, true
    change_column_null :product_categories, :product_id, true
    change_column_null :orders, :status, true
    change_column_null :orders, :delivery_address, true
    change_column_null :orders, :total_bill, true
    change_column_null :products, :name, true
    change_column_null :products, :current_price, true
    change_column_null :products, :quantity, true
    change_column_null :products, :status, true
    change_column_null :feedbacks, :reviewable_type, true
    change_column_null :feedbacks, :reviewable_id, true
    change_column_null :businesses, :name, true
    change_column_null :businesses, :status, true
  end
end

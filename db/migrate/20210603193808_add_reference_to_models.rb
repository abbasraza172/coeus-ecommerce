class AddReferenceToModels < ActiveRecord::Migration[6.1]
  def up
    add_reference :users, :business
    add_reference :products, :business
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

    change_column_null :feedbacks, :stars, false
    change_column_null :pictures, :name, false
    change_column_null :pictures, :imageable_type, false
    change_column_null :pictures, :imageable_id, false
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

    change_column_null :feedbacks, :stars, true
    change_column_null :pictures, :name, true
    change_column_null :pictures, :imageable_type, true
    change_column_null :pictures, :imageable_id, true
  end
end

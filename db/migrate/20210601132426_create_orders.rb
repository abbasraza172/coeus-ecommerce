class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :status
      t.string :delivery_address
      t.integer :total_bill
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

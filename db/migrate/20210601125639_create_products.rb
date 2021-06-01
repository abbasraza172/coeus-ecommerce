class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.int :current_price
      t.int :quantity
      t.boolean :status

      t.timestamps
    end
  end
end

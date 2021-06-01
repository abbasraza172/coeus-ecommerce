class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :current_price
      t.integer :quantity
      t.boolean :status
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    
  end
end

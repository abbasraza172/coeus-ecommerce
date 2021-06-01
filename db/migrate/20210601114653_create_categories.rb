class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.string :name, null: false
      t.boolean :status, null: false

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end

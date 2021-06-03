class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.integer :role, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :password
      t.string :phone
      t.boolean :status, null: false

      t.timestamps
    end
  end
end

class CreateBusinesses < ActiveRecord::Migration[6.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.text :description
      t.boolean :status, default: :true

      t.timestamps
    end
  end
end

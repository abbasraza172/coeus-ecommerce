class AddImageDataToPicture < ActiveRecord::Migration[6.1]
  def up
    add_column :pictures, :image_data, :text
    change_column :pictures, :name, :string, null: true
  end

  def down
    remove_column :pictures, :image_data
    change_column :pictures, :name, :string, null: false
  end
end

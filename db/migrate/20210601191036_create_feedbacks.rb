class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.integer :stars
      t.string :review
      t.references :user, null: false, foreign_key: true
      t.boolean :status

      t.references :reviewable, polymorphic: true

      t.timestamps
    end
  end
end

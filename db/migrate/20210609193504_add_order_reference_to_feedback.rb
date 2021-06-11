class AddOrderReferenceToFeedback < ActiveRecord::Migration[6.1]
  def up
    add_reference :feedbacks, :order
  end

  def down
    remove_column :feedbacks, :order_id
  end
end

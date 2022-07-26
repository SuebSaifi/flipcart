class RemoveCartIdUserIdAndProductIdFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :cart_id, :integer
    remove_column :orders, :user_id, :integer
    remove_column :orders, :product_id, :integer
  end
end

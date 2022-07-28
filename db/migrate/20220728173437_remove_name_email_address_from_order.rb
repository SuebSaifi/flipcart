class RemoveNameEmailAddressFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :name, :string
    remove_column :orders, :email, :string
    remove_column :orders, :address, :string
  end
end

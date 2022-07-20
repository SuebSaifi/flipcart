class AddBuyerAndSallerToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :buyer, :boolean,default: true
    add_column :users, :saller, :boolean ,default: false
  end
end

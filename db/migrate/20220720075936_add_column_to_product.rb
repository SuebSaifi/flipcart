class AddColumnToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :title, :string
    add_column :products, :price, :decimal
    add_column :products, :description, :text
  end
end

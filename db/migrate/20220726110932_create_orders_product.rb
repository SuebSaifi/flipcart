class CreateOrdersProduct < ActiveRecord::Migration[7.0]
  def change
    create_table :orders_products do |t|
      t.belongs_to  :order, index: true
      t.belongs_to  :product, index: true
      t.timestamps
    end
  end
end

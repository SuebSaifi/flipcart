class AddBrandToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :brand_id, :integer
  end
end

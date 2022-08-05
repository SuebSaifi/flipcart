class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end

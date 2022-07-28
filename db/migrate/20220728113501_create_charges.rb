class CreateCharges < ActiveRecord::Migration[7.0]
  def change
    create_table :charges do |t|
      t.integer :user_id
      t.integer :order_id

      t.timestamps
    end
  end
end

class CreateBrand < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :name
      t.timestamps
    end
  end
end

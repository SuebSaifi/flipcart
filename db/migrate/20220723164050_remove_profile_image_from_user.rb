class RemoveProfileImageFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :profile_image, :string
  end
end

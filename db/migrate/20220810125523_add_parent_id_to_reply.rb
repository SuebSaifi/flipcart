class AddParentIdToReply < ActiveRecord::Migration[7.0]
  def change
    add_column :replies, :parent_id, :integer
  end
end

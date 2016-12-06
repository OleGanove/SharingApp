class RemoveFpostIdFromLikes < ActiveRecord::Migration[5.0]
  def change
    remove_column :likes, :fpost_id, :integer
  end
end

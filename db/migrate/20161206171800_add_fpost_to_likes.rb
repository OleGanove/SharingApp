class AddFpostToLikes < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :fpost_id, :integer
  end
end

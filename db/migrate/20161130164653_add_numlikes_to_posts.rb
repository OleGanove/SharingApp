class AddNumlikesToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :lowlikes, :integer
    add_column :posts, :highlikes, :integer
  end
end

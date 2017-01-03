class AddLowviewsHighviewsToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :lowviews, :integer
    add_column :posts, :highviews, :integer
  end
end

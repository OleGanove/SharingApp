class AddLowviewsHighviewsToFposts < ActiveRecord::Migration[5.0]
  def change
    add_column :fposts, :lowviews, :integer
    add_column :fposts, :highviews, :integer
  end
end

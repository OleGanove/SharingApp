class AddTimeAgoToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :time_ago, :integer
  end
end

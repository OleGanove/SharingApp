class AddFirsttimevisitToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :first_time_visit, :timestamp
  end
end

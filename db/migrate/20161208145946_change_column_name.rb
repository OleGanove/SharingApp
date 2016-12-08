class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :first_time_visit, :first_time_visited_at
  end
end

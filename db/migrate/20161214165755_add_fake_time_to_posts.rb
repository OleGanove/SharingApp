class AddFakeTimeToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :fake_time, :timestamp
  end
end

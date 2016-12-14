class CreateRandomizedFposts < ActiveRecord::Migration[5.0]
  def change
    create_table :randomized_fposts do |t|
      t.integer :fpost_id
      t.integer :user_id
      t.timestamp :fake_time

      t.timestamps
    end
  end
end

class CreateFlikes < ActiveRecord::Migration[5.0]
  def change
    create_table :flikes do |t|
      t.integer :user_id
      t.integer :fpost_id

      t.timestamps
    end
  end
end

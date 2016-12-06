class CreateFposts < ActiveRecord::Migration[5.0]
  def change
    create_table :fposts do |t|
      t.string :description
      t.string :link
      t.boolean :pinned
      t.integer :lowlikes
      t.integer :highlikes
      t.integer :time_ago
      t.string :picture
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end

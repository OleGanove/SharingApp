class CreateViews < ActiveRecord::Migration[5.0]
  def change
    create_table :views do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end

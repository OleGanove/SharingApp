class AddReadersToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :lowreaders, :integer
    add_column :users, :highreaders, :integer
  end
end

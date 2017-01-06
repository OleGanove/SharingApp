class AddFuturepostToFposts < ActiveRecord::Migration[5.0]
  def change
    add_column :fposts, :futurepost, :boolean
  end
end

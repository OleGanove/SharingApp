class AddImageurlToFposts < ActiveRecord::Migration[5.0]
  def change
    add_column :fposts, :image_url, :string
  end
end

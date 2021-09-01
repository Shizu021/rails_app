class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :price, :string
    add_column :posts, :genre, :string
  end
end

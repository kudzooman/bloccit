class AddImagesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :images, :string
  end
end

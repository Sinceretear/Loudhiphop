class AddImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :images, :text
  end
end

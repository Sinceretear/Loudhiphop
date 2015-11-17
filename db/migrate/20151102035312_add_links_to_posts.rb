class AddLinksToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :Links, :string
  end
end

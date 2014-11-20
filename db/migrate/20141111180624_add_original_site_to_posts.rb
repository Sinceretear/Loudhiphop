class AddOriginalSiteToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :original_site, :string
  end
end

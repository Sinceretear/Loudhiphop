class AddOriginalSiteToHnhhDbs < ActiveRecord::Migration
  def change
    add_column :hnhh_dbs, :original_site, :string
  end
end

class CreateHnhhDbs < ActiveRecord::Migration
  def change
    create_table :hnhh_dbs do |t|
      t.string :title
      t.string :artist
      t.string :images
      t.string :slug

      t.timestamps
    end
  end
end

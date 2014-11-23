class CreateMixtapes < ActiveRecord::Migration
  def change
    create_table :mixtapes do |t|
      t.string :artist
      t.string :mx_name
      t.string :mx_cover

      t.timestamps
    end
  end
end

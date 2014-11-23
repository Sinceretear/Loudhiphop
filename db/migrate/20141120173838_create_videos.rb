class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :image
      t.string :link
      t.string :title

      t.timestamps
    end
  end
end

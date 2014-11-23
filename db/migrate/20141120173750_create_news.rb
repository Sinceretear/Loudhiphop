class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :image
      t.string :link
      t.string :title

      t.timestamps
    end
  end
end

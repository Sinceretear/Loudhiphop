class AddMxartistToMixtapes < ActiveRecord::Migration
  def change
    add_column :mixtapes, :mx_artist, :string
  end
end

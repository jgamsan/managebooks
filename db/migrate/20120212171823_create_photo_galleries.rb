class CreatePhotoGalleries < ActiveRecord::Migration
  def change
    create_table :photo_galleries do |t|
      t.integer :store_id
      t.string :photo

      t.timestamps
    end
  end
end

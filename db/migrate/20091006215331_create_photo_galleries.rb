class CreatePhotoGalleries < ActiveRecord::Migration
  def self.up
    create_table :photo_galleries do |t|
      t.string :name
      t.text :description
      t.integer :images_count
      t.string :permalink
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :photo_galleries
  end
end

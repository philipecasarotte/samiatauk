class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :name
      t.integer :position
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at
      t.integer :photo_gallery_id

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end

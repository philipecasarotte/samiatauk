class CreateDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.string :name
      t.string :permalink
      t.string :subject
      t.string :file_file_name
      t.integer :file_file_size
      t.string :file_content_type
      t.datetime :file_updated_at
      t.text :description
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end

class RemovePagesPermalink < ActiveRecord::Migration
  def self.up
    remove_column :pages, :permalink
  end

  def self.down
    add_column :pages, :permalink, :string
  end
end

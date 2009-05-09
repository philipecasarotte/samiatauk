class AddIndexToPages < ActiveRecord::Migration
  def self.up
    add_index :pages, :permalink, :unique => true
  end

  def self.down
    remove_index :pages, :column => :permalink
  end
end

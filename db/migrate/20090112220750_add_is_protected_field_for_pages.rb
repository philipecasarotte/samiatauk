class AddIsProtectedFieldForPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :is_protected, :boolean, :default=>false, :null=>false
  end

  def self.down
    remove_column :pages, :is_protected
  end
end

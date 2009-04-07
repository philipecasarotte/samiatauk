class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages, :force => true do |t|
      t.string :name
      t.string :permalink
      t.text :body
      t.integer :parent_id
      t.integer :children_count, :default=>0
      t.integer :position, :default=>0
      t.boolean :is_protected, :default => false, :null => false
      t.boolean :is_hidden, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end

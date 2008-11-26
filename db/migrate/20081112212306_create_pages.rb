class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages, :force => true do |t|
      t.string :title, :permalink
      t.text :body
      t.integer :parent_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end

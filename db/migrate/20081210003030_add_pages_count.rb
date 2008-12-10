class AddPagesCount < ActiveRecord::Migration
  def self.up
    add_column :pages, :children_count, :integer, :default => 0

    Page.reset_column_information
    Page.all.each do |p|
      Page.update_counters p.id, :children_count => p.children.count
    end
  end

  def self.down
    remove_column :pages, :children_count
  end
end

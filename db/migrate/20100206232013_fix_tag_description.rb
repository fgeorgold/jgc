class FixTagDescription < ActiveRecord::Migration
  def self.up
    add_column :tags, :description, :string  
  end

  def self.down
    remove_column :tags, :description, :string
  end
end

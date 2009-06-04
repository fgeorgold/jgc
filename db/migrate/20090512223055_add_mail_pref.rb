class AddMailPref < ActiveRecord::Migration
  def self.up
    add_column :users, :mailpref,  :boolean, :default => true
  end

  def self.down
    remove_column :users, :mailpref
  end
end

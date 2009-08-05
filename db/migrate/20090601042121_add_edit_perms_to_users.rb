class AddEditPermsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :edit_perms,  :boolean, :default => false
  end

  def self.down
    remove_column :users, :edit_perms
  end
end

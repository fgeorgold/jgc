class AddRoleToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin,  :boolean, :default => false 
  end

  def self.down
    drop_table :users
  end
end

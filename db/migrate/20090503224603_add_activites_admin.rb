class AddActivitesAdmin < ActiveRecord::Migration
  def self.up
    add_column :users, :activitesadmin,  :boolean, :default => false
  end

  def self.down
    remove_column :users, :activitesadmin
  end
end

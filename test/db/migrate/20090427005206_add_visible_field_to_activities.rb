class AddVisibleFieldToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :visible,  :boolean, :default => false 
  end

  def self.down
  end
end

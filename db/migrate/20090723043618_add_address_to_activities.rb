class AddAddressToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :address, :text
  end

  def self.down
    remove_column :activities, :address
  end
end

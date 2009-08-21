class AddLatLon < ActiveRecord::Migration
  def self.up
    add_column :activities, :lat, :text
    add_column :activities, :lon, :text
  end

  def self.down
    remove_column :activities, :lat
    remove_column :activities, :lon
  end
end

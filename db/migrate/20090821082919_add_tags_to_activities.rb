class AddTagsToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :taggedAs, :string
  end

  def self.down
    remove_column :activities, :taggedAs
  end
end

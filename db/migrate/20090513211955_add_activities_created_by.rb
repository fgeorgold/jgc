class AddActivitiesCreatedBy < ActiveRecord::Migration
  def self.up
    add_column :activities, :created_by,  :string
  end

  def self.down
    remove_column :activities, :created_by
  end
end

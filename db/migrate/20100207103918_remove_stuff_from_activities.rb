class RemoveStuffFromActivities < ActiveRecord::Migration
  def self.up
    remove_column :activities, :instructions
    remove_column :activities, :otherPrograms
    remove_column :activities, :resources
  end

  def self.down
    add_column :activities, :instructions, :text
    add_column :activities, :otherPrograms, :string
    add_column :activities, :resources, :text
  end
end

class AddActivitiestoTag < ActiveRecord::Migration
  def self.up
    create_table :activities_tags, :id => false do |t|
      t.integer :activity_id
      t.integer :tag_id
    end
  add_index :activities_tags, [:tag_id, :activity_id], :unique => true
  add_index :activities_tags, :tag_id, :unique => false #enable fast lookup on tag id
  end

  def self.down
    drop_table :activities_tags
  end


end

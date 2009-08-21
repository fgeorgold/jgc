class FixRelationships < ActiveRecord::Migration
  def self.up
    change_column :activities_comments, :activity_id, :integer
    change_column :activities_favorites, :pd_user_id, :integer
    change_column :tags, :activity_id, :integer
    change_column :programs, :activity_id, :integer
  end

  def self.down
    change_column :activities_comments, :activity_id, :string
    change_column :activities_favorites, :pd_user_id, :string
    change_column :tags, :activity_id, :string
    change_column :programs, :activity_id, :string
  end
end

class FixTypoInFavoriteActivities < ActiveRecord::Migration
  def self.up
    rename_column "activities_favorites", "activitiy_id", "activity_id"
  end

  def self.down
    rename_column "activities_favorites", "activity_id", "activitiy_id"
  end
end

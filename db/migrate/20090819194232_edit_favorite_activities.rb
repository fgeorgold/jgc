class EditFavoriteActivities < ActiveRecord::Migration
  def self.up
    rename_column "activities_favorites", "Pduser_id", "pd_user_id"
  end

  def self.down
    rename_column "activities_favorites", "Pduser_id", "pd_user_id"
  end
end

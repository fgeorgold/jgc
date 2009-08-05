class AddFavoriteActivities < ActiveRecord::Migration
  def self.up
    create_table :activities_favorites do |t|
      t.string :Pduser_id
      t.string :activitiy_id     
    end
  end

  def self.down
    drop_table :activities_favorites
  end
end

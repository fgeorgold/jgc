class AddTimestampsToComments2 < ActiveRecord::Migration
  def self.up
	change_table :activities_comments do |t|
		t.timestamps
	end
  end

  def self.down
  end
end

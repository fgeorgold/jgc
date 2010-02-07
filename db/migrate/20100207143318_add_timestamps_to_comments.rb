class AddTimestampsToComments < ActiveRecord::Migration
  def self.up
	change_table :comments do |t|
		t.timestamps
	end
  end

  def self.down
  end
end

class ChangePdUserName < ActiveRecord::Migration
  def self.up
    rename_column :pd_users, :screen_name, :login_name 
  end

  def self.down
  end
end

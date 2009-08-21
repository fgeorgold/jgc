class AddPdUserToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :pd_user_id, :integer
  end

  def self.down
    remove_column :activities, :pd_user_id
  end
end

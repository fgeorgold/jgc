class CreatePdUsers < ActiveRecord::Migration
  def self.up
    create_table :pd_users do |t|
      t.column :login_name, :string      
      t.column :email, :string
      t.column :password, :string
      t.column :authorization_token, :string      
    end
  end

  def self.down
    drop_table :pd_users
  end
end

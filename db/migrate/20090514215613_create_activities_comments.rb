class CreateActivitiesComments < ActiveRecord::Migration
  def self.up
    create_table :activities_comments do |t|
      t.column :activity_id, :string
      t.column :comment_text, :text
      t.column :email, :string
      t.column :visible, :boolean, :default => false 
    end
  end

  def self.down
     drop_table :activities_comments
  end
end

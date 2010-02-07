class DropComments < ActiveRecord::Migration
  def self.up
    drop_table :comments
  end
  
  def self.down
    create_table :comments do |t|
      t.column :comment_text, :text
      t.column :email, :string
      t.column :name, :string
      end
  end

end

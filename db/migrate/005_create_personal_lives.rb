class CreatePersonalLives < ActiveRecord::Migration
  def self.up
    create_table :personal_lives do |t|
      t.column :pd_user_id, :integer, :null => false
      t.column :bio,                     :text
      t.column :academic_background,     :text
      t.column :interests,               :text
      t.column :other_info,              :text
    end
  end

  def self.down
    drop_table :personal_lives
  end
end

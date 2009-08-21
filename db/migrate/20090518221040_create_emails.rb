class CreateEmails < ActiveRecord::Migration
  def self.up
    create_table :emails do |t|
      t.text :from, :to
      t.text :mail
      t.text :subject
      t.timestamps
    end
  end

  def self.down
    drop_table :emails
  end
end

class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.text :description
      t.text :resources
      t.string :contact
      t.string :email
      t.text :partners

      t.timestamps
    end

  end

  def self.down
    drop_table :organizations
  end
end

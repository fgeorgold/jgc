class AddZipToOrg < ActiveRecord::Migration
  def self.up
    add_column :organizations, :zipcode, :text
  end

  def self.down
    remove_column :organizations, :zipcode
  end
end

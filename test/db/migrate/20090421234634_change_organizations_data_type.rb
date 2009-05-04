class ChangeOrganizationsDataType < ActiveRecord::Migration
  def self.up
    change_column :organizations, :partners, :string
  end

  def self.down
    change_column :organizations, :partners, :text
  end
end

class AddInformationToOrganizations < ActiveRecord::Migration
  def self.up
        
      add_column :organizations, :visible,  :boolean, :default => false 
      add_column :organizations, :asp, :text
  end

  def self.down
    
      drop_table :organizations
  end
end

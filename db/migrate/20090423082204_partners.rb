class Partners < ActiveRecord::Migration
  def self.up
  create_table :partners do |t|
      t.column :organization_id, :string
      t.column :partner_org_id, :string
    end
  end

  def self.down
    drop_table :partners
  end
end
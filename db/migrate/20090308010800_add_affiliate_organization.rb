class AddAffiliateOrganization < ActiveRecord::Migration
  def self.up
    add_column :users, :affiliateOrg,  :string
  end

  def self.down
  end
end

class CreateSpecs < ActiveRecord::Migration
  def self.up
    create_table :specs do |t|
      t.column :pd_user_id, :integer, :null    => false
      t.column :first_name, :string,  :default => ""
      t.column :last_name,  :string,  :default => ""
      t.column :gender,     :string
      t.column :birthdate,  :date
      t.column :occupation, :string,  :default => ""
      t.column :city,       :string,  :default => ""
      t.column :state,      :string,  :default => ""
      t.column :zip_code,   :string,  :default => ""
    end
  end

  def self.down
    drop_table :specs
  end
end
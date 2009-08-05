class ChangesToSpecs < ActiveRecord::Migration
  def self.up
    add_column :specs, :address,          :string,  :default => ""
    add_column :specs, :work_phone,       :string,  :default => ""
    add_column :specs, :fax,              :string,  :default => ""
    add_column :specs, :home_phone,       :string,  :default => ""
    add_column :specs, :cell_phone,       :string,  :default => ""
    add_column :specs, :current_employee, :string,  :default => ""
    add_column :specs, :age_group,        :string,  :default => ""
  end

  def self.down
    drop_table :specs
  end
end
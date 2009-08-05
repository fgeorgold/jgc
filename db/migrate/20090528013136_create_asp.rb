class CreateAsp < ActiveRecord::Migration
  def self.up
    create_table :asps do |t|
      t.column :program_id, :string
      t.column :program_name, :string
    end
  end

  def self.down
    drop_table :asps
  end
end


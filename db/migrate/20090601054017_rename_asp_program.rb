class RenameAspProgram < ActiveRecord::Migration
  def self.up
    rename_column :asps, :program_id, :organization_id
  end

  def self.down
    rename_column :asps, :organization_id,:program_id
  end
end

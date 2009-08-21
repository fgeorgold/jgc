class FixActivityRelationship < ActiveRecord::Migration
  def self.up
	rename_column :activities, :programs, :otherPrograms
  end

  def self.down
	rename_column :activities, :otherPrograms, :programs
  end
end

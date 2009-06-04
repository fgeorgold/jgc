class ChangesToProfessionalLives < ActiveRecord::Migration
  def self.up
    remove_column :professional_lives, :current_employee
  end

  def self.down
    drop_table :professional_lives
  end
end
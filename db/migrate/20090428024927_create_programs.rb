class CreatePrograms < ActiveRecord::Migration
  def self.up
    create_table :programs do |t|
      t.column :activity_id, :string
      t.column :program_name, :string
    end
  end

  def self.down
    drop_table :programs
  end
end

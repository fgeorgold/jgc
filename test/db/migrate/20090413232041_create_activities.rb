class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.text :resources
      t.text :cost
      t.text :comments
      t.string :duration
      t.text :instructions
      t.string :programs
      t.string :age_group
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end

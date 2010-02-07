class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.string :file_name
      t.datetime :date_time
      t.references :activity

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end

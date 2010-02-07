class DropZipTable < ActiveRecord::Migration
  def self.up
    drop_table "zips"
  end

  def self.down
  end
end

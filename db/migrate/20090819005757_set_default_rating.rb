class SetDefaultRating < ActiveRecord::Migration
  def self.up
    change_column "ratings", "rating", :integer, :default =>3
  end

  def self.down
    change_column "ratings", "rating", :integer, :default =>0
  end
end

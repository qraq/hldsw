class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :users, :kill, :points
  end

  def self.down
    rename_column :users, :points, :kill
  end
end
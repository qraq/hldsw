class AddLastKillToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_kill, :integer, :default => 0

  end

  def self.down
    remove_column :users, :last_kill
  end
end

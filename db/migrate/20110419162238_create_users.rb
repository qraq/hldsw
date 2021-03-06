class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :ip
      t.string :email
      t.integer :kill
      t.integer :death
      t.boolean :admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

class Permalink < ActiveRecord::Migration
  def self.up
    add_index :users, :permalink
  end

  def self.down
    remove_index :users, :permalink
  end
end

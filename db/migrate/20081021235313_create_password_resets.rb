class CreatePasswordResets < ActiveRecord::Migration
  def self.up
    create_table :password_resets do |t|
      t.integer :user_id
      t.string :token
      t.string :email

      t.timestamps
    end
    add_index :password_resets, :token
  end

  def self.down
    drop_table :password_resets
  end
end

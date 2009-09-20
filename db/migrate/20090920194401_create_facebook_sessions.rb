class CreateFacebookSessions < ActiveRecord::Migration
  def self.up
    create_table :facebook_sessions do |t|
      t.integer :user_id
      t.integer :uid
      t.string :session_key

      t.timestamps
    end
    
    add_index :facebook_sessions, :uid
    add_index :facebook_sessions, :user_id
  end

  def self.down
    drop_table :facebook_sessions
  end
end

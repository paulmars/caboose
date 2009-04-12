# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_caboose_session',
  :secret      => '35773c415b83e1becbb98f6f3fbb23fd013eb45e5927a581983a2fffe49950cc51092aeeba71a297dd883aa64adb098626f70f287861f4cee3f70e1f98f0a026'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

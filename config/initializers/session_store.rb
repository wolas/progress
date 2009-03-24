# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wundertask_session',
  :secret      => '323357aa2865bd5bd90eabc4fd9c2c2e8905f18cfcf1422b20351d6009aa52dd3dcf1881d441978714550507929d892b0280678eb35e67a41028e2a62d6bf39d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

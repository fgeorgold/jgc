# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Demo_session',
  :secret      => 'dc62f9db485a3c211907c295ab6218e6a37b2737d6770c172979e1f30955403ceb2c398528db6283a4abf22ffd8bff77064fd3e25da3959311512e3664e699c9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

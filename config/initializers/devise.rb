# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  # ==> Mailer Configuration
  # Configure the e-mail address which will be shown in Devise::Mailer,
  # note that it will be overwritten if you use your own mailer class with default "from" parameter.
  config.mailer_sender = "noreply@example.com"
  
  require 'devise/orm/active_record'
  
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]
  
  config.stretches = Rails.env.test? ? 1 : 10

  # Setup a pepper to generate the encrypted password.
  # config.pepper = "54192d8fe8488d324c246233fef8ae730dc5e46aeb9966b666c7689d9596c67bfe1896d90d21de7121499b1a7b310ad429526fec4eae2e20e604b625aca04463"

  # ==> Configuration for :confirmable
  config.reconfirmable = true

  config.password_length = 8..128

  # Email regex used to validate email formats. It simply asserts that
  # an one (and only one) @ exists in the given string. This is mainly
  # to give user feedback and not to assert the e-mail validity.
  config.email_regexp = /\A[^@]+@[^@]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  
  # OAuth
  require "omniauth-twitter"
  config.omniauth :twitter, "", ""
end

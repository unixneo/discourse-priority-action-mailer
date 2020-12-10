smtp_address_priority = defined?(GlobalSetting.smtp_address_priority) ? GlobalSetting.smtp_address_priority : GlobalSetting.smtp_address
smtp_port_priority = defined?(GlobalSetting.smtp_port_priority) ? GlobalSetting.smtp_port_priority : GlobalSetting.smtp_port
smtp_user_name_priority = defined?(GlobalSetting.smtp_user_name_priority) ? GlobalSetting.smtp_user_name_priority : GlobalSetting.smtp_user_name
smtp_password_priority = defined?(GlobalSetting.smtp_password_priority) ? GlobalSetting.smtp_password_priority : GlobalSetting.smtp_password
smtp_authentication_priority = defined?(GlobalSetting.smtp_authentication_priority) ? GlobalSetting.smtp_authentication_priority : GlobalSetting.smtp_authentication
smtp_enable_start_tls_priority = defined?(GlobalSetting.smtp_enable_start_tls_priority) ? GlobalSetting.smtp_enable_start_tls_priority : GlobalSetting.smtp_enable_start_tls

smtp_address_digest = defined?(GlobalSetting.smtp_address_digest) ? GlobalSetting.smtp_address_digest : GlobalSetting.smtp_address
smtp_port_digest = defined?(GlobalSetting.smtp_port_digest) ? GlobalSetting.smtp_port_digest : GlobalSetting.smtp_port
smtp_user_name_digest = defined?(GlobalSetting.smtp_user_name_digest) ? GlobalSetting.smtp_user_name_digest : GlobalSetting.smtp_user_name
smtp_password_digest = defined?(GlobalSetting.smtp_password_digest) ? GlobalSetting.smtp_password_digest : GlobalSetting.smtp_password
smtp_authentication_digest = defined?(GlobalSetting.smtp_authentication_digest) ? GlobalSetting.smtp_authentication_digest : GlobalSetting.smtp_authentication
smtp_enable_start_tls_digest = defined?(GlobalSetting.smtp_enable_start_tls_digest) ? GlobalSetting.smtp_enable_start_tls_digest : GlobalSetting.smtp_enable_start_tls

smtp_address_mentions = defined?(GlobalSetting.smtp_address_mentions) ? GlobalSetting.smtp_address_mentions : GlobalSetting.smtp_address
smtp_port_mentions = defined?(GlobalSetting.smtp_port_mentions) ? GlobalSetting.smtp_port_mentions : GlobalSetting.smtp_port
smtp_user_name_mentions = defined?(GlobalSetting.smtp_user_name_mentions) ? GlobalSetting.smtp_user_name_mentions : GlobalSetting.smtp_user_name
smtp_password_mentions = defined?(GlobalSetting.smtp_password_mentions) ? GlobalSetting.smtp_password_mentions : GlobalSetting.smtp_password
smtp_authentication_mentions = defined?(GlobalSetting.smtp_authentication_mentions) ? GlobalSetting.smtp_authentication_mentions : GlobalSetting.smtp_authentication
smtp_enable_start_tls_mentions = defined?(GlobalSetting.smtp_enable_start_tls_mentions) ? GlobalSetting.smtp_enable_start_tls_mentions : GlobalSetting.smtp_enable_start_tls

Rails.application.config.priority_smtp_settings = {
  address: smtp_address_priority,
  port: smtp_port_priority,
  user_name: smtp_user_name_priority,
  password: smtp_password_priority,
  authentication: smtp_authentication_priority,
  enable_starttls_auto: smtp_enable_start_tls_priority,
}

Rails.application.config.digest_smtp_settings = {
  address: smtp_address_digest,
  port: smtp_port_digest,
  user_name: smtp_user_name_digest,
  password: smtp_password_digest,
  authentication: smtp_authentication_digest,
  enable_starttls_auto: smtp_enable_start_tls_digest,
}

Rails.application.config.mentions_smtp_settings = {
  address: smtp_address_mentions,
  port: smtp_port_mentions,
  user_name: smtp_user_name_mentions,
  password: smtp_password_mentions,
  authentication: smtp_authentication_mentions,
  enable_starttls_auto: smtp_enable_start_tls_mentions,
}

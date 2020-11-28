# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.29
# date: 28 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

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

after_initialize do
  AdminConfirmationMailer.class_eval do
    before_action :priority_smtp_settings

    def priority_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        AdminConfirmationMailer.smtp_settings = Rails.application.config.priority_smtp_settings
      end
    end
  end

  UserNotifications.class_eval do
    before_action :priority_smtp_settings, only: [:email_login, :signup, :forgot_password, :admin_login]
    before_action :digest_smtp_settings, only: [:digest]
    before_action :default_smtp_settings, except: [:email_login, :signup, :forgot_password, :admin_login, :digest]

    def priority_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = Rails.application.config.priority_smtp_settings
      end
    end

    def digest_smtp_settings
      if GlobalSetting.smtp_password_digest.present?
        UserNotifications.smtp_settings = Rails.application.config.digest_smtp_settings
      end
    end

    def default_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = Rails.application.config.action_mailer.smtp_settings
      end
    end
  end
end

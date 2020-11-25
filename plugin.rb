# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.23
# date: 24 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

smtp_address_priority = defined?(GlobalSetting.smtp_address_priority) ? GlobalSetting.smtp_address_priority : GlobalSetting.smtp_address
smtp_port_priority = defined?(GlobalSetting.smtp_port_priority) ? GlobalSetting.smtp_port_priority : GlobalSetting.smtp_port
smtp_user_name_priority = defined?(GlobalSetting.smtp_user_name_priority) ? GlobalSetting.smtp_user_name_priority : GlobalSetting.smtp_user_name
smtp_password_priority = defined?(GlobalSetting.smtp_password_priority) ? GlobalSetting.smtp_password_priority : GlobalSetting.smtp_password
smtp_authentication_priority = defined?(GlobalSetting.smtp_authentication_priority) ? GlobalSetting.smtp_authentication_priority : GlobalSetting.smtp_authentication
smtp_enable_start_tls_priority = defined?(GlobalSetting.smtp_enable_start_tls_priority) ? GlobalSetting.smtp_enable_start_tls_priority : GlobalSetting.smtp_enable_start_tls

PRIORITY_SMTP_SETTINGS = {
  address: smtp_address_priority,
  port: smtp_port_priority,
  user_name: smtp_user_name_priority,
  password: smtp_password_priority,
  authentication: smtp_authentication_priority,
  enable_starttls_auto: smtp_enable_start_tls_priority,
}

after_initialize do
  AdminConfirmationMailer.class_eval do
    before_action :update_smtp_settings

    def update_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        AdminConfirmationMailer.smtp_settings = PRIORITY_SMTP_SETTINGS
      end
    end
  end

  UserNotifications.class_eval do
    before_action :update_smtp_settings, only: [:email_login, :signup, :forgot_password, :admin_login]
    before_action :default_smtp_settings, except: [:email_login, :signup, :forgot_password, :admin_login]

    def update_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = PRIORITY_SMTP_SETTINGS
      end
    end

    def default_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = Rails.application.config.action_mailer.smtp_settings
      end
    end
  end
end

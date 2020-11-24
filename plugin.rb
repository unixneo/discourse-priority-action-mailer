# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.17
# date: 24 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

PRIORITY_SMTP_SETTINGS = {
  address: GlobalSetting.smtp_address_priority,
  port: GlobalSetting.smtp_port_priority,
  user_name: GlobalSetting.smtp_user_name_priority,
  password: GlobalSetting.smtp_password_priority,
  authentication: GlobalSetting.smtp_authentication,
  enable_starttls_auto: GlobalSetting.smtp_enable_start_tls,
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
    before_action :update_smtp_settings, only: [:email_login]

      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = PRIORITY_SMTP_SETTINGS
      end
    end
  end
end

# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.13
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

NEODEBUG = true

after_initialize do
  AdminConfirmationMailer.instance_eval do
    before_action :high_priority_smtp_settings

    def high_priority_smtp_settings
      puts ">>>>> NEO AdminConfirmationMailer GlobalSetting.smtp_password_priority #{GlobalSetting.smtp_password_priority}" if NEODEBUG
      if GlobalSetting.smtp_password_priority.present?
        puts ">>>>> NEO AdminConfirmationMailer PRIORITY_SMTP_SETTINGS #{PRIORITY_SMTP_SETTINGS}" if NEODEBUG
        AdminConfirmationMailer.smtp_settings = PRIORITY_SMTP_SETTINGS
        puts ">>>>> NEO AdminConfirmationMailer AdminConfirmationMailer.smtp_settings #{AdminConfirmationMailer.smtp_settings}" if NEODEBUG
      end
    end
  end

  UserNotifications.instance_eval do
    before_action :high_priority_smtp_settings, only: [:email_login]

    def high_priority_smtp_settings
      puts ">>>>> NEO UserNotifications GlobalSetting.smtp_password_priority #{GlobalSetting.smtp_password_priority}" if NEODEBUG
      if GlobalSetting.smtp_password_priority.present?
        puts ">>>>> NEO UserNotifications PRIORITY_SMTP_SETTINGS #{PRIORITY_SMTP_SETTINGS}" if NEODEBUG
        UserNotifications.smtp_settings = PRIORITY_SMTP_SETTINGS
        puts ">>>>> NEO UserNotifications UserNotifications.smtp_settings #{UserNotifications.smtp_settings}" if NEODEBUG
      end
    end
  end
end

# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.8
# date: 23 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

HIGH_PRIORITY_SMTP_SETTINGS = {
  address: GlobalSetting.smtp_address_priority,
  port: GlobalSetting.smtp_port_priority,
  user_name: GlobalSetting.smtp_user_name_priority,
  password: GlobalSetting.smtp_password_priority,
  authentication: "plain": GlobalSetting.smtp_authentication,
  enable_starttls_auto: GlobalSetting.smtp_enable_start_tls,
}

NEODEBUG = true

after_initialize do
  AdminConfirmationMailer.class_eval do
    before_action :high_priority_smtp_settings

    private

    def high_priority_smtp_settings
      puts ">>>>> NEO AdminConfirmationMailer GlobalSetting.smtp_password_priority #{GlobalSetting.smtp_password_priority}" if NEODEBUG
      if GlobalSetting.smtp_password_priority.present?
        puts ">>>>> NEO AdminConfirmationMailer HIGH_PRIORITY_SMTP_SETTINGS #{HIGH_PRIORITY_SMTP_SETTINGS}" if NEODEBUG
        AdminConfirmationMailer.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
        puts ">>>>> NEO AdminConfirmationMailer AdminConfirmationMailer.smtp_settings #{AdminConfirmationMailer.smtp_settings}" if NEODEBUG
      end
    end
  end

  UserNotifications.class_eval do
    before_action :high_priority_smtp_settings, only: [:email_login]

    private

    def high_priority_smtp_settings
      puts ">>>>> NEO UserNotifications GlobalSetting.smtp_password_priority #{GlobalSetting.smtp_password_priority}" if NEODEBUG
      if GlobalSetting.smtp_password_priority.present?
        puts ">>>>> NEO UserNotifications HIGH_PRIORITY_SMTP_SETTINGS #{HIGH_PRIORITY_SMTP_SETTINGS}" if NEODEBUG
        UserNotifications.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
        puts ">>>>> NEO UserNotifications UserNotifications.smtp_setting #{UserNotifications.smtp_settingS}" if NEODEBUG
      end
    end
  end
end

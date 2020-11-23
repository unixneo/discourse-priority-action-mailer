# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.2
# date: 23 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

HIGH_PRIORITY_SMTP_SETTINGS = {
  address: ENV["SMTP_ADDRESS_PRIORITY"],
  port: ENV["SMTP_PORT_PRIORITY"],
  domain: ENV["SMTP_DOMAIN_PRIORITY"],
  user_name: ENV["SMTP_USERNAME_PRIORITY"],
  password: ENV["SMTP_PASSWORD_PRIORITY"],
  authentication: "plain",
  enable_starttls_auto: true,
}

after_initialize do
  AdminConfirmationMailer.class_eval do
    before_action :high_priority_smtp_settings

    def high_priority_smtp_settings
      if ENV["SMTP_ADDRESS_PRIORITY"].present?
        AdminConfirmationMailer.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
      end
    end
  end

  UserNotifications.class_eval do
    before_action :high_priority_smtp_settings, only: [:email_login]

    def high_priority_smtp_settings
      if ENV["SMTP_ADDRESS_PRIORITY"].present?
        UserNotifications.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
      end
    end
  end
end

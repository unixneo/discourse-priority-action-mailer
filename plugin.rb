# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.2
# date: 23 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

HIGH_PRIORITY_SMTP_SETTINGS = {
  :address => "my.email.server.com",
  :port => 587,
  :user_name => "my_email_address",
  :password => "my_email_password",
  :authentication => "plain",
  :enable_starttls_auto => true,
}

  after_initialize do
    AdminConfirmationMailer.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
    AdminConfirmationMailer.class_eval do
      before_action :high_priority_smtp_settings

      def high_priority_smtp_settings
        AdminConfirmationMailer.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
      end
    end

    UserNotifications.class_eval do
      before_action :high_priority_smtp_settings, only: [:digest]

      def high_priority_smtp_settings
        UserNotifications.smtp_settings = HIGH_PRIORITY_SMTP_SETTINGS
      end
    end
  end
end

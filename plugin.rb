# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.0.34
# date: 28 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

plugin_root = "#{Rails.root}/plugins/discourse-developers-dashboard".freeze
configure_smtp_settings = "#{plugin_root}/lib/configure_smtp_settings.rb".freeze
load File.open(configure_smtp_settings)

after_initialize do
  AdminConfirmationMailer.class_eval do
    before_action :set_priority_smtp_settings

    def set_priority_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        AdminConfirmationMailer.smtp_settings = Rails.application.config.priority_smtp_settings
      end
    end
  end

  UserNotifications.class_eval do
    before_action :set_default_smtp_settings, except: [:email_login, :signup, :forgot_password, :admin_login, :digest]
    before_action :set_priority_smtp_settings, only: [:email_login, :signup, :forgot_password, :admin_login]
    before_action :set_digest_smtp_settings, only: [:digest]

    def set_priority_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = Rails.application.config.priority_smtp_settings
      end
    end

    def set_digest_smtp_settings
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

# frozen_string_literal: true

# name: discourse-priority-action-mailer
# about: plugin to add priority smtp_settings to action mailer
# version: 0.11
# date: 30 Nov 2020
# authors: Neo
# url: https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

PLUGIN_NAME = "discourse-priority-action-mailer"

require File.expand_path("../lib/configure_smtp_settings.rb", __FILE__)

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

    def set_default_smtp_settings
      if GlobalSetting.smtp_password_priority.present?
        UserNotifications.smtp_settings = Rails.application.config.action_mailer.smtp_settings
      end
    end
  end
end

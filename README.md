# discourse-priority-action-mailer

## WHAT DOES THIS PLUGIN DO?

This Discourse plugin creates new a "high priority" SMTP "channel" for "higher priority" SMTP messages and a new "digest" channel only for digests sent to users, including the ```AdminConfirmationMailer``` and the following methods in the ```UserNotifications``` mailer:

#### PRIORITY CHANNEL ACTIONS
- :email_login, 
- :signup, 
- :forgot_password, 
- :admin_login

#### DIGEST CHANNEL ACTION
- :digest

This new "high priority" SMTP channel should be different than your standard channel where Discourse sends out digests, etc.

## WHO SHOULD USE THIS PLUGIN?

We discovered the need for this plugin when we migrated to Discourse and forgot to turn off digests and our SMTP server was inundated with digest messages.   When this happened, users could not login and Discourse was not accessible to anyone who needed to login.   We realized that Discourse would be more reliable if there was an SMTP channel for "low priority email messages" like user notifications and digests and a "higher priority channel" for user logins, email logines, forgot passwords, signups, etc. and so the idea for this plugin was born.

So, this plugin is useful for anyone who want to keep "mission critical" SMTP traffic out of the same SMTP channel as the run-of-the-mill "not mission critical" SMTP traffic, especially if your site sends at lot of digests or has the potential to inundate your SMTP channel.


## HOW TO INSTALL THIS PLUGIN?

The following additional Discourse container environment vars are required, unless you want the default values.  These SMTP environmental variable are basically the same as the Discourse default SMTP environmental variables with the ```_PRIORITY``` and ```_DIGEST``` added to each one:

#### PRIORITY CHANNEL ENVIRONMENTALS

```
env:
  DISCOURSE_SMTP_ADDRESS_PRIORITY:                     
  DISCOURSE_SMTP_PORT_PRIORITY: 
  DISCOURSE_SMTP_USER_NAME_PRIORITY: 
  DISCOURSE_SMTP_PASSWORD_PRIORITY: 
  DISCOURSE_SMTP_AUTHENTICATION_PRIORITY:               # normally set to plain
  DISCOURSE_SMTP_ENABLE_START_TLS_PRIORITY:             # normally set to true
```

#### DIGEST CHANNEL ENVIRONMENTALS

```
env:
  DISCOURSE_SMTP_ADDRESS_DIGEST:                     
  DISCOURSE_SMTP_PORT_DIGEST: 
  DISCOURSE_SMTP_USER_NAME_DIGEST: 
  DISCOURSE_SMTP_PASSWORD_DIGEST: 
  DISCOURSE_SMTP_AUTHENTICATION_DIGEST:               # normally set to plain
  DISCOURSE_SMTP_ENABLE_START_TLS_DIGEST:             # normally set to true
```

In addition, you need install this plugin, which is this repo:

https://github.com/unixneo/discourse-priority-action-mailer

## DEFAULTS

If you do not include any new environmental variable in your Discourse container yml files, or an any are omitted, the
default is the Discourse default SMTP settings for these variables.

## SEE ALSO

#### Support

https://community.unix.com/t/discourse-priority-action-mailer-plugin/380941

#### Meta Discourse Announcement

https://meta.discourse.org/t/discourse-priority-action-mailer-plugin/171871

#### Original Plugin Concept Notes:

https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

####  NOTES

1.  This plugin does not effect the core SMTP default channel which is visible in the Discourse Admin panel.  Nor does this SMTP channel display in the Admin panel (yet).   If anyone is interested to send a PR and code the EmberJS part to display in the Discourse Admin panel, please do.

2.  This plugin has a fixed set of "high priority" methods.     If anyone wants to include other Discourse ActionMailer methods, please let me know and we will consider adding it; or feel free to fork and modify.





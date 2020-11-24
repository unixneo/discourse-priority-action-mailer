# discourse-priority-action-mailer

## WHAT DOES THIS PLUGIN DO?

This Discourse plugin creates a new "high priority" SMTP "channel" for "higher priority" SMTP messages, including the ```AdminConfirmationMailer``` and the following methods in the ```UserNotifications``` mailer:

- :email_login, 
- :signup, 
- :forgot_password, 
- :admin_login

This new "high priority" SMTP channel should be different than your standard channel where Discourse sends out digests, etc.

## WHO SHOULD USE THIS PLUGIN?

We discovered the need for this plugin when we migrated to Discourse and forgot to turn off digests and our SMTP server was inundated with digest messages.   When this happened, users could not login and Discourse was not accessible to anyone who needed to login.   We realized that Discourse would be more reliable if there was an SMTP channel for "low priority email messages" like user notifications and digests and a "high priority channel" for user logins, email logines, forgot passwords, signups, etc. and so the idea for this plugin was born.

So, this plugin is useful for anyone who want to keep "mission critical" SMTP traffic out of the same SMTP channel as the run-of-the-mill "not mission critical" SMTP traffic, especially if your site sends at lot of digests or has the potential to inundate your SMTP channel.

### HOW TO INSTALL THIS PLUGIN?

The following additional Discourse container environment vars are required, unless you want the default values.  These SMTP environmental variable are basically the same as the Discourse default SMTP environmental variables with the ```_PRIORITY``` added to each one:

```
env:
  DISCOURSE_SMTP_ADDRESS_PRIORITY:                     
  DISCOURSE_SMTP_PORT_PRIORITY: 
  DISCOURSE_SMTP_USER_NAME_PRIORITY: 
  DISCOURSE_SMTP_PASSWORD_PRIORITY: 
  DISCOURSE_SMTP_AUTHENTICATION_PRIORITY:               # normally set to plain
  DISCOURSE_SMTP_ENABLE_START_TLS_PRIORITY:             # normally set to true
```

In addition, you need install this plugin, which is this repo:

https://github.com/unixneo/discourse-priority-action-mailer

 ### SEE ALSO

 #### Plugin Notes:

https://community.unix.com/t/creating-higher-priority-smtp-settings-in-discourse-software-mailers-a-future-plugin-idea/380865

###  NOTES

1.  This plugin does not effect the core SMTP default channel which is visible in the Discourse Admin panel.  Nor does this SMTP channel display in the Admin panel (yet).   If anyone is interested to send a PR and code the EmberJS part to display in the Discourse Admin panel, please do.

2.  This plugin has a fixed set of "high priority" methods.     If anyone wants to include other Discourse ActionMailer methods, please let me know and we will consider adding it; or feel free to fork and modify.





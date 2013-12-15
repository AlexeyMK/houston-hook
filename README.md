houston-hook
============

Use the [Houston] Meteor Admin as a standalone separate app, hosted on meteor.com.

Instructions:

- (in your app) `mrt add houston-hook`
- Re-deploy your app. If you're hosting on meteor.com, `mrt deploy yourapp.meteor.com`
- (in your app) ./packages/houston-hook/deploy-admin.sh [admin-app name, or will default to <folder-name>-admin.meteor.com]

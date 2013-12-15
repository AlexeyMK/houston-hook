houston-hook
============

Use the [Houston] Meteor Admin as a standalone separate app, hosted on meteor.com.

Instructions (for production use):

- (in your app) `mrt add houston-hook`
- Re-deploy your app. If you're hosting on meteor.com, `mrt deploy yourapp.meteor.com`
- (in your app) `./packages/houston-hook/deploy-admin.sh` with two arguments: 
  - Production App URL (IE, yourapp.meteor.com) or your custom location, and   
  - optional: Desired admin URL will default to <folder-name>-admin.meteor.com

Instructions (for local use):
TODO

How it works:
TODO

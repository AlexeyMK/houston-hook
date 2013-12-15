Package.describe({
  summary: "Mongo Hook for standalone Meteor app"
});

Package.on_use(function(api) {
  api.use('coffeescript', ['server']);
  api.add_files(['server/methods.coffee'], 'server');
});

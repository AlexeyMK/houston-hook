if (Meteor.isServer) {
  Meteor.startup(function() {
    if (Meteor.settings.app_mongourl) {
      process.env.MONGO_URL = Meteor.settings.app_mongourl;
      console.log("MONGO_URL set");
    }
  });
} else {
  Router.map(function() {
    this.route("home", {
      path: "/",
      action: function() {
        this.redirect("/admin");
      }
    })
  });
}

HoustonHook = new Meteor.Collection("_houston_hook")
Fiber = Npm.require('fibers')

Meteor.startup ->
  webapp_response = (req, res, next) ->
    unless req.method is "GET" and req.url is "/_houston_hook"
      next() # normal app behavior
    else
      console.log "in fiber"
      hook_exists = HoustonHook.find().count() > 0
      console.log "after hook", hook_exists
      if hook_exists
        res.writeHead(403)
        # TODO now as nice of an error message in debug
        res.end("Houston already set up - db.getCollection('_houston_hook').remove() to remove")
      else
        console.log "pre insert"
        hook_log = _.chain(req).pick("url", "headers", "method").extend(
          client_ip: req.connection.remoteAddress
          timestamp: Date.now()
        ).value()
        HoustonHook.insert hook_log, (error, _id) ->
          if error
            res.writeHead(500)
            res.end("On Insert: #{error}")
          else
            res.writeHead(200)
            res.end(process.env.MONGO_URL)

  bound_webapp_response = Meteor.bindEnvironment webapp_response, (error) ->
    res.writeHead(500)
    res.end("In bindEnvironment: #{error}")

  WebApp.connectHandlers.use bound_webapp_response

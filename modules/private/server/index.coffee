exports = module.exports = (context, modules, done) ->
  express = require 'express'
  http = require 'http'

  # Create our app
  app = express()

  # Configure our app
  app.set 'port', context.config.server.port
  context.logger.silly 'Using configured port:', app.get('port')

  # Configure our server
  server = http.createServer app

  # When bijous has completed loading all modules, start our server
  context.on 'done', ->
    server.listen app.get('port'), (err) ->
      throw err if err
      context.logger.silly 'Server is now listening for incoming requests.'

  # Return an object containing the relevant objects that may be used by other
  # modules
  done null,
    express: express
    app: app
    server: server

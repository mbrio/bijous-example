path = require 'path'
jade = require 'jade'

exports = module.exports = (context, modules, done) ->
  express = modules.private.server.express
  app = modules.private.server.app

  app.engine 'jade', jade.__express
  app.set 'view engine', 'jade'

  homePath = path.join context.cwd, 'modules', 'public', 'app', 'views',
    'index.jade'
  lessRegex = /\.less$/i
  coffeeRegex = /\.coffee$/i

  response =
    home: (req, res) ->
      pm = context.list('public').urls().map (url) ->
        url.replace coffeeRegex, '.js'
      ps = context.list('stylesheets').urls().map (url) ->
        url.replace lessRegex, '.css'

      res.render homePath,
        modules: pm
        styles: ps

  done null, response

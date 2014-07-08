path = require 'path'
fs = require 'fs'
less = require 'less'

exports = module.exports = (context, modules, done) ->
  express = modules.private.server.express
  app = modules.private.server.app

  apiRouter = new express.Router

  apiRouter.get '/', modules.private.root.get
  apiRouter.get '/hello', modules.private.hello.get

  webRouter = new express.Router
  webRouter.get '/', modules.private.website.home

  module = context.list 'public'
  views = context.list 'views'
  styles = context.list 'stylesheets'

  lessRegex = /\.less$/i

  files = module.files()
  urls = module.urls()

  for file, i in files
    url = urls[i]
    filePath = path.join context.cwd, file

    webRouter.get url, ((filePath) ->
      (req, res) ->
        res.sendfile filePath
    )(filePath)

  files = views.files()
  urls = views.urls()
  regex = /\.jade$/i

  for file, i in files
    url = urls[i]
    filePath = path.join context.cwd, file

    webRouter.get url.replace(regex, '.html'), ((filePath) ->
      (req, res) ->
        publicModules = module.urls()
        publicStylesheets = styles.urls().map (url) ->
          url.replace lessRegex, '.css'

        res.render filePath,
          modules: publicModules
          styles: publicStylesheets
    )(filePath)

  files = styles.files()
  urls = styles.urls()

  for file, i in files
    url = urls[i]
    filePath = path.join context.cwd, file

    webRouter.get url.replace(lessRegex, '.css'), ((filePath) ->
      (req, res) ->
        fs.readFile filePath, (err, data) ->
          throw err if err
          less.render data.toString(), (e, css) ->
            throw e if e
            res.type('text/css').send css
    )(filePath)

  app.use '/api', apiRouter
  app.use webRouter

  done null, null

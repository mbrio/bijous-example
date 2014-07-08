less = require './less'
jade = require './jade'
coffee = require './coffee'

exports = module.exports = (context, results) ->
  { express, app } = results.private.server
  { website } = results.private

  router = new express.Router
  router.get '/', website.home

  modules = context.list 'public'
  views = context.list 'views'
  styles = context.list 'stylesheets'

  lessRegex = /\.less$/i

  publicModules = modules.urls()
  publicStylesheets = styles.urls().map (url) ->
    url.replace lessRegex, '.css'

  coffee context, router, modules
  jade context, router, views, publicModules, publicStylesheets
  less context, router, styles

  app.use router

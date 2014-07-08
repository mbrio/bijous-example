exports = module.exports = (context, results) ->
  { express, app } = results.private.server
  { root, hello } = results.private

  router = new express.Router

  router.get '/', root.get
  router.get '/hello', hello.get

  app.use '/api', router

pack = require '../../../package.json'

exports = module.exports = (context, results, done) ->
  done null,
    # Create our get express request
    get: (req, res) ->
      res.json
        version: pack.version
        links:
          root: '/'
          hello: '/hello'
          info: '/info/'

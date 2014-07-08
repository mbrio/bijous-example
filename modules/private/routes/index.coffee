api = require './api'
web = require './web'

exports = module.exports = (context, results, done) ->
  api context, results
  web context, results

  done null, null

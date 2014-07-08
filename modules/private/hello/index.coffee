messages = require './messages'

exports = module.exports = (context, modules, done) ->
  done null,
    # Create our get express request
    get: (req, res) ->
      res.json messages()

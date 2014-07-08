path = require 'path'
fs = require 'fs'
less = require 'less'

exports = module.exports = (context, router, bundle) ->
  lessRegex = /\.less$/i

  files = bundle.files()
  urls = bundle.urls()

  for file, i in files
    url = urls[i]
    filePath = path.join context.cwd, file

    router.get url.replace(lessRegex, '.css'), ((filePath) ->
      (req, res) ->
        fs.readFile filePath, (err, data) ->
          throw err if err
          less.render data.toString(), (e, css) ->
            throw e if e
            res.type('text/css').send css
    )(filePath)

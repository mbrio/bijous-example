path = require 'path'
fs = require 'fs'
coffee = require 'coffee-script'

exports = module.exports = (context, router, bundle) ->
  coffeeRegex = /\.coffee$/i

  files = bundle.files()
  urls = bundle.urls()

  for file, i in files
    url = urls[i]
    filePath = path.join context.cwd, file

    router.get url.replace(coffeeRegex, '.js'), ((filePath) ->
      (req, res) ->
        if coffeeRegex.test filePath
          fs.readFile filePath, (err, data) ->
            throw err if err
            txt = coffee.compile data.toString()
            res.type('application/javascript').send txt
        else
          res.sendfile filePath
    )(filePath)

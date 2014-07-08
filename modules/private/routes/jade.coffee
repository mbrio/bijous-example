path = require 'path'
fs = require 'fs'

exports = module.exports = (context, router, bundle, modules, styles) ->
  jadeRegex = /\.jade$/i

  files = bundle.files()
  urls = bundle.urls()

  for file, i in files
    url = urls[i]
    filePath = path.join context.cwd, file

    router.get url.replace(jadeRegex, '.html'), ((filePath) ->
      (req, res) ->
        res.render filePath,
          modules: modules
          styles: styles
    )(filePath)

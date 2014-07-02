'use strict';

var path = require('path');
var fs = require('fs')

exports = module.exports = function (context, done) {
  var express = context.modules.server.express;
  var app = context.modules.server.app;

  var router = new express.Router();

  app.get('/', context.modules.root.get);
  app.get('/hello', context.modules.hello.get);
  app.get('/site', context.modules.website.home);

  var module = context.modules.website.publicModules;

  var files = module.files();
  var urls = module.urls();

  for (var f in files) {
    var file = files[f];
    var url = urls[f];
    var filePath = path.join(context.cwd, file);

    app.get(url, function (req, res) {
      res.sendfile(filePath);
    });
  }

  app.use(router);

  done(null, null);
};
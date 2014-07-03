'use strict';

var path = require('path');
var fs = require('fs')

exports = module.exports = function (context, done) {
  var express = context.modules.server.express;
  var app = context.modules.server.app;

  var apiRouter = new express.Router();

  apiRouter.get('/', context.modules.root.get);
  apiRouter.get('/hello', context.modules.hello.get);

  var webRouter = new express.Router();
  webRouter.get('/', context.modules.website.home);

  var module = context.modules.website.publicModules;

  var files = module.files();
  var urls = module.urls();

  for (var f in files) {
    var file = files[f];
    var url = urls[f];
    var filePath = path.join(context.cwd, file);

    webRouter.get(url, (function (filePath) {
      return function (req, res) {
        res.sendfile(filePath);
      };
    })(filePath));
  }

  var views = context.modules.website.publicViews;

  files = views.files();
  urls = views.urls();
  var regex = /\.jade$/i;

  for (var f in files) {
    var file = files[f];
    var url = urls[f];
    var filePath = path.join(context.cwd, file);

    webRouter.get(url.replace(regex, '.html'), (function (filePath) {
      return function (req, res) {
        var publicModules = module.urls();
        res.render(filePath, { modules: publicModules });
      };
    })(filePath));
  }

  app.use('/api', apiRouter);
  app.use(webRouter);

  done(null, null);
};
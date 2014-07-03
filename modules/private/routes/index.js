'use strict';

var path = require('path');
var fs = require('fs')

exports = module.exports = function (context, done) {
  var express = context.modules.private.server.express;
  var app = context.modules.private.server.app;

  var apiRouter = new express.Router();

  apiRouter.get('/', context.modules.private.root.get);
  apiRouter.get('/hello', context.modules.private.hello.get);

  var webRouter = new express.Router();
  webRouter.get('/', context.modules.private.website.home);

  var module = context.modules.private.website.publicModules;
  var views = context.modules.private.website.publicViews;
  var styles = context.modules.private.website.publicStylesheets;

  var lessRegex = /\.less$/i;

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
        var publicStylesheets = styles.urls().map(function (url) {
          return url.replace(lessRegex, '.css');
        });
        res.render(filePath, { modules: publicModules, styles: publicStylesheets });
      };
    })(filePath));
  }

  files = styles.files();
  urls = styles.urls();
  var less = require('less');
  var rs = require('fs');

  for (var f in files) {
    var file = files[f];
    var url = urls[f];
    var filePath = path.join(context.cwd, file);

    webRouter.get(url.replace(lessRegex, '.css'), (function (filePath) {
      return function (req, res) {
        fs.readFile(filePath, function (err, data) {
          if (err) { throw err; }
          less.render(data.toString(), function (e, css) {
            if (e) { throw e; }
            res.type('text/css').send(css);
          });
        });
      };
    })(filePath));
  }

  app.use('/api', apiRouter);
  app.use(webRouter);

  done(null, null);
};
'use strict';

var path = require('path');
var jade = require('jade');

exports = module.exports = function (context, done) {
  var express = context.modules.private.server.express;
  var app = context.modules.private.server.app;

  app.engine('jade', jade.__express);
  app.set('view engine', 'jade');

  var homePath = path.join(context.cwd, 'modules', 'public', 'app', 'views', 'index.jade');
  var lessRegex = /\.less$/i;

  var response = {
    publicModules: context.list('public'),
    publicViews: context.list('views'),
    publicStylesheets: context.list('stylesheets'),
    home: function (req, res) {
      var publicModules = response.publicModules.urls();
      var publicStylesheets = response.publicStylesheets.urls().map(function (url) {
        return url.replace(lessRegex, '.css');
      });
      res.render(homePath, { modules: publicModules, styles: publicStylesheets });
    }
  };

  done(null, response);
};
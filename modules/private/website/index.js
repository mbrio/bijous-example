'use strict';

var path = require('path');
var jade = require('jade');

exports = module.exports = function (context, done) {
  var express = context.modules.server.express;
  var app = context.modules.server.app;

  app.engine('jade', jade.__express);
  app.set('view engine', 'jade');

  var homePath = path.join(context.cwd, 'modules', 'public', 'app', 'views', 'index.jade');

  var response = {
    publicModules: context.list('public'),
    publicViews: context.list('views'),
    publicStylesheets: context.list('stylesheets'),
    home: function (req, res) {
      var publicModules = response.publicModules.urls();
      res.render(homePath, { modules: publicModules });
    }
  };

  done(null, response);
};
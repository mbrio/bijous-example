'use strict';

exports = module.exports = function (context, done) {
  var express = context.modules.server.express;
  var app = context.modules.server.app;

  var router = new express.Router();
  
  app.get('/', context.modules.root.get);
  app.get('/hello', context.modules.hello.get);

  app.use(router);

  done(null, null);
};
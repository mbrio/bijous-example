'use strict';

exports = module.exports = function (context, done) {
  var express = require('express');
  var http = require('http');

  // Create our app
  var app = express();

  // Configure our app
  app.set('port', context.config.server.port);
  context.logger.silly('Using configured port:', app.get('port'));

  // Configure our server
  var server = http.createServer(app);

  // When bijous has completed loading all modules, start our server
  context.on('done', function () {
    server.listen(app.get('port'), function (err) {
      if (err) { throw err; }
      context.logger.silly('Server is now listening for incoming requests.');
    });
  });

  // Return an object containing the relevant objects that may be used by other
  // modules
  done(null, {
    express: express,
    app: app,
    server: server
  });
};
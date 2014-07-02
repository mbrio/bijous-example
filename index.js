'use strict';

var Bijous = require('bijous');
var winston = require('winston');

var startDate = new Date();

// Create our `Bijous` instance
var bijous = new Bijous({
  // Override the CWD
  cwd: __dirname,

  // Setup our modules, we need the server module loaded first and the router
  // module loaded last, all other modules can be loaded as necessary.
  bundles: {
    private: [
      'modules/private/server',
      'modules/private/!(router)',
      'modules/private/router'
    ]
  }
});

// The `config` property is not part of `Bijous`; as our `Bijous` instance is
// passed as a context parameter to each module we can store properties here
// that can be used by all modules.
bijous.config = { server: { port: 3000 } };

// Setup a logger for use by our modules
bijous.logger = new winston.Logger();
bijous.logger.setLevels(winston.config.npm.levels);
bijous.logger.add(winston.transports.Console, {
  colorize: true,
  timestamp: true,
  exitOnError: true,
  level: 'silly'
});

bijous.load('private', function (err, results) {
  var duration = new Date() - startDate;
  bijous.logger.silly('Loaded all modules in:', duration, 'ms');
});
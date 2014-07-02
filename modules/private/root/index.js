'use strict';

var pack = require('../../../package.json');

exports = module.exports = function (context, done) {
  done(null, {
    // Create our get express request
    get: function (req, res) {
      res.json({
        version: pack.version,
        links: {
          root: '/',
          hello: '/hello'
        }
      });
    }
  });
};
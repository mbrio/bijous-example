'use strict';

var messages = require('./messages');

exports = module.exports = function (context, done) {
  done(null, {
    // Create our get express request
    get: function (req, res) {
      res.json({
        hello: messages()
      });
    }
  });
};
'use strict';

var messages = {
  en: 'hello',
  jp: 'こんにちは',
  de: 'hallo'
};

var messageKeys = Object.keys(messages);

exports = module.exports = function () {
  var rand = Math.floor((Math.random() * messageKeys.length) + 1);
  var key = messageKeys[rand - 1];

  return {
    lang: key,
    message: messages[key]
  };
};
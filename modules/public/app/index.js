(function () {
  'use strict';

  angular
    .module('BijousExample', ['ui.router'])
    .config(function ($urlRouterProvider) {
      $urlRouterProvider.otherwise('/');
    });
})();
angular
  .module('BijousExample', ['ui.router'])
  .config ($urlRouterProvider) ->
    $urlRouterProvider.otherwise '/'

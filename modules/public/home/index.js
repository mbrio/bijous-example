(function () {
  'use strict';

  angular
    .module('BijousExample')
    .config(function ($stateProvider) {
      $stateProvider
        .state('home', {
          url: '/',
          templateUrl: '/modules/public/home/index.html',
          controller: 'HomeController'
        });
    })
    .controller('HomeController', function ($scope, $http) {
      $scope.msg = 'Loading...'

      $http.get('/api/hello')
        .success(function (data, status, headers, config) {
          if (status === 200) {
            $scope.msg = null;
            $scope.hello = data.message;
            $scope.lang = data.lang;
          } else {
            $scope.msg = 'An error has occurred.';
          }
        })
        .error(function () {
          $scope.msg = 'An error has occurred.';
        });
    });
})();
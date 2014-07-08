angular
  .module('BijousExample')
  .config ($stateProvider) ->
    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: '/modules/public/home/views/index.html'
        controller: 'HomeController'
  .controller 'HomeController', ($scope, $http) ->
    $scope.msg = 'Loading...'

    $http.get('/api/hello')
      .success (data, status, headers, config) ->
        if status is 200
          $scope.msg = null
          $scope.hello = data.message
          $scope.lang = data.lang
        else
          $scope.msg = 'An error has occurred.'
      .error ->
        $scope.msg = 'An error has occurred.'

'use strict';

angular.module('APIM.api', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/api', {
    templateUrl: 'views/api/api.html',
    controller: 'api_ctrl'
  });
}])

.controller('api_ctrl', function($scope, $http) {

 
});
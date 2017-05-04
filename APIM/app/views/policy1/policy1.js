'use strict';

angular.module('APIM.policy1', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/policy1', {
    templateUrl: 'views/policy1/policy1.html',
    controller: 'policy1_ctrl'
  });
}])

.controller('policy1_ctrl', function($scope, $http) {

  
});
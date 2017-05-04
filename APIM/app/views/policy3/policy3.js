'use strict';

angular.module('APIM.policy3', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/policy3', {
    templateUrl: 'views/policy3/policy3.html',
    controller: 'policy3_ctrl'
  });
}])

.controller('policy3_ctrl', function($scope, $http) {

 
});
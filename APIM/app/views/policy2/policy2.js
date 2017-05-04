'use strict';

angular.module('APIM.policy2', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/policy2', {
    templateUrl: 'views/policy2/policy2.html',
    controller: 'policy2_ctrl'
  });
}])

.controller('policy2_ctrl', function($scope, $http) {

   
});
'use strict';

angular.module('APIM.reset_password', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/reset_password', {
    templateUrl: 'views/reset_password/reset_password.html',
    controller: 'reset_password_ctrl'
  });
}])

.controller('reset_password_ctrl', function($scope, $http) {

   
});
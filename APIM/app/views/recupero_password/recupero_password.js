'use strict';

angular.module('APIM.recupero_password', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/recupero_password', {
    templateUrl: 'views/recupero_password/recupero_password.html',
    controller: 'recupero_password_ctrl'
  });
}])

.controller('recupero_password_ctrl', function($scope, $http) {

  
});
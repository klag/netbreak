'use strict';

angular.module('APIM.registra_api', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/registra_api', {
    templateUrl: 'views/registra_api/registra_api.html',
    controller: 'registra_api_ctrl'
  });
}])

.controller('registra_api_ctrl', function($scope, $http) {

   
});
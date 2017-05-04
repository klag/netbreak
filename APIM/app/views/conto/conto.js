'use strict';

angular.module('APIM.conto', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/conto', {
    templateUrl: 'views/conto/conto.html',
    controller: 'conto_ctrl'
  });
}])

.controller('conto_ctrl', function($scope, $http) {

 
});
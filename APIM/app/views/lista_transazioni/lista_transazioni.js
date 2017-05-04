'use strict';

angular.module('APIM.lista_transazioni', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/lista_transazioni', {
    templateUrl: 'views/lista_transazioni/lista_transazioni.html',
    controller: 'lista_transazioni_ctrl'
  });
}])

.controller('lista_transazioni_ctrl', function($scope, $http) {

   
});
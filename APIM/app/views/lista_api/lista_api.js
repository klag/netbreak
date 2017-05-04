'use strict';

angular.module('APIM.lista_api', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/lista_api', {
    templateUrl: 'views/lista_api/lista_api.html',
    controller: 'lista_api_ctrl'
  });
}])

.controller('lista_api_ctrl', function($scope, $http) {
	$http.get("http://localhost:8100/homepage_ms_list").then(function(response) {
        $scope.mslistdata = response.data;
    });


	/*funzione che filtra api per categoria. Da completare per ottenere un filtro totalmente locale*/
    $scope.filter = function(event){
    	/*questo alert prende come id l'id del bottone premuto, che corrisponde all'id della categoria*/
    	alert(event.target.id);
	}
});
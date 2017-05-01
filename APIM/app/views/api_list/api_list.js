'use strict';

angular.module('myApp.api_list', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/api_list', {
    templateUrl: 'views/api_list/api_list.html',
    controller: 'api_listCtrl'
  });
}])

.controller('api_listCtrl', [function($scope, $http) {
	$http.get("/getApi") 
	    .success(function(data) { 
	        $scope.api_list = data; 
	    }) 
	    .error(function() { 
	        alert("Si è verificato un errore!"); 
	    })
}]);


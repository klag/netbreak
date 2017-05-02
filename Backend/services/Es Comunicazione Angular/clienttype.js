var app = angular.module('demo', []);
app.controller('clienttypeCntrl', function($scope, $http) {
  $http.get("http://localhost:8101/retrieve_client_type?Id=2").then(function(response) {
	  $scope.ctdata = response.data;
    });
});
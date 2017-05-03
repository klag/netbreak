var app = angular.module('myApp', []);
app.controller('exampleCntrl', function($scope, $http) {
	$http.get("http://localhost:8100/homepage_filter_cat_list?Id=1").then(function(response) {
		$scope.exampledata = response.data;
	});
});
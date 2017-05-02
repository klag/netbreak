var app = angular.module('myapp', []);
app.controller('api_homeCtrl', function($scope, $http) {
    $http.get("http://localhost:8121/retrieve_last_registered_ms?number=5").then(function(response) {
        $scope.dataBack = response.data;
    });
});
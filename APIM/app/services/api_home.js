var app = angular.module('myapp', []);
app.controller('api_homeCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_ms_list").then(function(response) {
        $scope.mslistdata = response.data;
    });
});


'use strict';

angular.module('myApp.api_home', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/api_home', {
        templateUrl: 'views/api_home/api_home.html',
        controller: 'api_homeCtrl'
    });
}])

.controller('api_homeCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_ms_list").then(function(response) {
        $scope.mslistdata = response.data;
    });
});
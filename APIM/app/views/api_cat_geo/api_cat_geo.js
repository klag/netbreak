'use strict';

angular.module('myApp.api_cat_geo', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/api_cat_geo', {
        templateUrl: 'views/api_cat_geo/api_cat_geo.html',
        controller: 'api_cat_geoCtrl'
    });
}])

.controller('api_cat_geoCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_filter_cat_list?Id=4").then(function(response) {
        $scope.mslistdata = response.data;
    });
});
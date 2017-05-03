'use strict';

angular.module('myApp.api_cat_giochi', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/api_cat_giochi', {
        templateUrl: 'views/api_cat_giochi/api_cat_giochi.html',
        controller: 'api_cat_giochiCtrl'
    });
}])

.controller('api_cat_giochiCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_filter_cat_list?Id=1").then(function(response) {
        $scope.mslistdata = response.data;
    });
});
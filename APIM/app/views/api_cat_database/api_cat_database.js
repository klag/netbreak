'use strict';

angular.module('myApp.api_cat_database', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/api_cat_database', {
        templateUrl: 'views/api_cat_database/api_cat_database.html',
        controller: 'api_cat_databaseCtrl'
    });
}])

.controller('api_cat_databaseCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_filter_cat_list?Id=3").then(function(response) {
        $scope.mslistdata = response.data;
    });
});
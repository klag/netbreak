'use strict';

angular.module('myApp.api_cat_multimedia', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/api_cat_multimedia', {
        templateUrl: 'views/api_cat_multimedia/api_cat_multimedia.html',
        controller: 'api_cat_multimediaCtrl'
    });
}])

.controller('api_cat_multimediaCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_filter_cat_list?Id=2").then(function(response) {
        $scope.mslistdata = response.data;
    });
});
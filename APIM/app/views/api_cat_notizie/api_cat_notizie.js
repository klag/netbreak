'use strict';

angular.module('myApp.api_cat_notizie', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/api_cat_notizie', {
        templateUrl: 'views/api_cat_notizie/api_cat_notizie.html',
        controller: 'api_cat_notizieCtrl'
    });
}])

.controller('api_cat_notizieCtrl', function($scope, $http) {
    $http.get("http://localhost:8100/homepage_filter_cat_list?Id=5").then(function(response) {
        $scope.mslistdata = response.data;
    });
});
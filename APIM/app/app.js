'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngRoute',
  'myApp.api_home',
  'myApp.api_cat_giochi',
  'myApp.api_cat_multimedia',
  'myApp.api_cat_notizie',
  'myApp.api_cat_database',
  'myApp.api_cat_geo',
  'myApp.version'
]).
config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider) {
  $locationProvider.hashPrefix('');
  $routeProvider.otherwise({redirectTo: '/api_home'});
}]);

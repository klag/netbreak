'use strict';

// Declare app level module which depends on views, and components
angular.module('myapp', [
  'ngRoute',
  'myApp.view1',
  'myApp.view2',
  'myApp.api_list',
  'myApp.version'
]).
config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider) {
  $locationProvider.hashPrefix('!');

  $routeProvider.otherwise({redirectTo: 'views/view1'});
}]);

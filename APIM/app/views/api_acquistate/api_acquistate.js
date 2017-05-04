'use strict';

angular.module('APIM.api_acquistate', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/api_acquistate', {
    templateUrl: 'views/api_acquistate/api_acquistate.html',
    controller: 'api_acquistate_ctrl'
  });
}])

.controller('api_acquistate_ctrl', function($scope, $http) {

  
});
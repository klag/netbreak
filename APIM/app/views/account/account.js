'use strict';

angular.module('APIM.account', ['ngRoute'])

.config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/account', {
    templateUrl: 'views/account/account.html',
    controller: 'account_ctrl'
  });
}])

.controller('account_ctrl', function($scope, $http) {

  
});
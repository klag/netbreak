'use strict';

// Declare app level module which depends on views, and components
angular.module('APIM', [
  'ngRoute',
  'APIM.registra_utente',
  'APIM.login',
  'APIM.account',
  'APIM.api',
  'APIM.api_acquistate',
  'APIM.api_registrate',
  'APIM.lista_api',
  'APIM.lista_transazioni',
  'APIM.conto',
  'APIM.policy1',
  'APIM.policy2',
  'APIM.policy3',
  'APIM.recupero_password',
  'APIM.registra_api',
  'APIM.reset_password',
  'APIM.version'
]).
config(['$locationProvider', '$routeProvider', function($locationProvider, $routeProvider) {
  $locationProvider.hashPrefix('!');

  $routeProvider.otherwise({redirectTo: '/lista_api'});
}]);

var app = angular.module('my-App', ['jsonService']);

app.controller('ApiHome', function($scope, JsonService) {
    JsonService.get(function(home){
        $scope.LatestApi = home.LatestApi;
    });
});
app.directive "jsonPaster", [
  () ->
    templateUrl: 'templates/json-paster.html'
    scope: {
      model: '='
      label: '@'
    }
    link: (scope, elm, attrs) ->
      scope.update = () ->
        scope.model = JSON.parse elm.find('textarea').val()

]
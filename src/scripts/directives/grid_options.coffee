app.directive "gridOptions", [
  '$interval'

  ($interval) ->
    templateUrl: 'templates/grid-options.html'
    scope: {
      model: '='
      options: '='
      label: '@'
      groupname: '@'
    }
    link: (scope, elm, attrs) ->
      # select
      scope.select = (option) ->
        scope.model = option.value
]
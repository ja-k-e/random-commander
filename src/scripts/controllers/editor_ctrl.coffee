app.controller 'EditorCtrl', [
  '$scope'

  ($scope) ->

    # view variables
    $scope.view = {
      group: 'oscillators'
    }

    $scope.editor = $scope.$parent.editor

]
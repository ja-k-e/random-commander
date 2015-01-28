app.controller 'EditorCtrl', [
  '$scope'

  ($scope) ->

    # view variables
    $scope.view = {
      group: 'global'
    }

    $scope.editor = $scope.$parent.editor

]
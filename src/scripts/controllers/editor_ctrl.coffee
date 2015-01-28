app.controller 'EditorCtrl', [
  '$scope'

  ($scope) ->

    # view variables
    $scope.view = {
      group: 'global'
    }

    $scope.updateComposition = (val) ->
      $scope.$parent.composition = val
      $scope.$parent.generatePerformance()

    $scope.editor = $scope.$parent.editor

]
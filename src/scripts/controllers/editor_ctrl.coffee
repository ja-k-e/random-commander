app.controller 'EditorCtrl', [
  '$scope'

  ($scope) ->

    # view variables
    $scope.view = {
      t_data: 'values'
      b_data: 'values'
    }

    $scope.editor = $scope.$parent.editor

    # change row
    $scope.dataRow = (data, clef) ->
      if clef == 't'
        $scope.view.t_data = data
      else if clef == 'b'
        $scope.view.b_data = data
      else
        $scope.view.t_data = data

]
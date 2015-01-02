app.controller 'DataCtrl', [
  '$scope'
  'DataLibrary'
  ($scope, DataLibrary) ->
    # data library
    $scope.library = DataLibrary

    # the composition
    $scope.composition = {
      measures: 12 # measures to generate
      tempo: 120 # tempo of performance
      beats: 4 # beats per measure
      resolution: 1/16 # smallest note
      root: 5 # root of key
    }

    # treble clef
    $scope.treble = {
      values: [0,0,10,5,0,0,0,0,0,0]
      intervals: [10,0,0,5,0,0,5,0,0,0,5,0]
      chords: [10,5,0,0,0]
      octaves: [5,10,5]
    }

    # bass clef
    $scope.bass = {
      values: [0,0,10,5,0,0,0,0,0,0]
      intervals: [10,0,0,5,0,0,5,0,0,0,5,0]
      chords: [10,5,0,0,0]
      octaves: [5,10,5]
    }

    # view variables
    $scope.view = {
      t_data: 'values'
      b_data: 'values'
    }
    # change row
    $scope.dataRow = (data, clef) ->
      if clef == 't'
        $scope.view.t_data = data
      else if clef == 'b'
        $scope.view.b_data = data
      else
        $scope.view.t_data = data

]
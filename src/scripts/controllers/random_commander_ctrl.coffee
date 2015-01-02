app.controller 'RandomCommanderCtrl', [
  '$scope'
  'DataLibrary'
  'Performance'

  ($scope, DataLibrary, Performance) ->

    # data library
    $scope.library = DataLibrary

    # the composition
    $scope.composition = {
      measures: 12 # measures to generate
      tempo: 120 # tempo of performance
      beats: 4 # beats per measure
      resolution: 16 # smallest note
      root: 5 # root of key
      clefs: {
        treble: {
          values: [0,0,10,5,0,0,0,0,0,0]
          intervals: [10,0,0,5,0,0,5,0,0,0,5,0]
          chords: [10,5,0,0,0]
          octaves: [5,10,5]
          silence: 5
          baseoctave: 5
          waveform: 'sine'
          decibles: -4
        }
        bass: {
          values: [0,0,10,5,0,0,0,0,0,0]
          intervals: [10,0,0,5,0,0,5,0,0,0,5,0]
          chords: [10,5,0,0,0]
          octaves: [5,10,5]
          silence: 5
          baseoctave: 3
          waveform: 'sine'
          decibles: -4
        }
      }
    }

    $scope.performance = Performance.getPerformance($scope.composition)

    console.log $scope.performance

    # generate composition
    $scope.generateComposition = () ->
      composition = $scope.composition
      performance = $scope.performance

      transport = new Tone.Transport()
      transport.setBpm(composition.tempo)
      Tone.Transport.setInterval( (time) ->
        envelope.triggerAttack(time)
      , composition.resolution + "n")


      #create one of Tone's built-in synthesizers
      osc = new Tone.Oscillator(440, "sine")
      osc2 = new Tone.Oscillator(840, "sine")
      osc.setVolume -24.0
      osc2.setVolume -24.0
      #connect the synth to the master output channel
      osc.toMaster()
      osc2.toMaster()
      #create a callback which is invoked every quarter note
      osc.start(0)
      osc2.start(0)
      osc.stop("+4n")
      osc2.stop("+4n")

      # start the transport
      transport.start()
]
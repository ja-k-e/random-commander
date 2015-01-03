app.controller 'RandomCommanderCtrl', [
  '$scope'
  'DataLibrary'
  'Performance'

  ($scope, DataLibrary, Performance) ->

    # data library
    $scope.library = DataLibrary

    # metronome
    $scope.metronome = false

    # the composition
    $scope.composition = {
      measures: 12 # measures to generate
      tempo: 120 # tempo of performance
      beats: 4 # beats per measure
      resolution: 16 # smallest note
      root: 3 # root of key
      clefs: {
        treble: {
          values: [5,0,10,5,5,0,0,0,0]
          intervals: [10,0,0,5,0,0,0,5,0,0,5,0]
          chords: [10,5,5,0,0]
          octaves: [5,8,10]
          silence: 3
          baseoctave: 5
          waveform: 'sawtooth'
          decibels: -12
        }
        bass: {
          values: [10,10,10,0,0,0,0,0,0]
          intervals: [10,0,0,10,0,0,0,10,0,0,0,0]
          chords: [10,2,0,0,0]
          octaves: [4,10,4]
          silence: 2
          baseoctave: 3
          waveform: 'sawtooth'
          decibels: -12
        }
      }
    }

    $scope.performance = Performance.getPerformance($scope.composition)

    # generate composition
    $scope.generatePerformance = () ->
      $scope.stopPerformance()
      $scope.performance = Performance.getPerformance($scope.composition)
    console.log $scope.performance[0].length,$scope.performance[1].length

    # playing state
    $scope.playing = false
    # current step for view
    $scope.current_step = 0
    # clearing and playing performance interval
    performance_interval = undefined

    # play performance
    $scope.playPerformance = () ->
      $scope.playing = true
      waveforms = [$scope.composition.clefs.treble.waveform, $scope.composition.clefs.bass.waveform]
      decibels = [$scope.composition.clefs.treble.decibels, $scope.composition.clefs.bass.decibels]
      # total beat count
      beats = $scope.composition.measures * ($scope.composition.beats * ($scope.composition.resolution / 4))
      # css width of beat
      beat_width = 100 / beats
      # relative index
      index = 0
      # tempo to ms
      tempo_time = 60000 / $scope.composition.tempo

      # single beat instance
      next_beat = () ->

        $('.beat:nth-child(' + (index + 1) + ')').addClass 'active'

        for sequence, i in $scope.performance
          chord = sequence[index]
          if $scope.metronome && index % $scope.composition.beats == 0
            if index % ($scope.composition.beats * $scope.composition.beats) then freq = 3000 else freq = 4000
            metronome = new Tone.Oscillator(freq, 'square')
            # set volume in decibels
            metronome.setVolume -30
            # metronome to master
            metronome.toMaster()
            # start metronome
            metronome.start(0)
            # stop metronome after sustain
            metronome.stop("+16n")

          # if beat in any rhythm array has value
          if i == 0 then clef = 'treble' else clef = 'bass'
          if typeof chord == "object"
            # beats per second
            bps = $scope.composition.tempo / 60
            # how much of a beat is the length
            beat_count = chord.length / 0.25
            # sustain of the note in seconds
            chord_length_secs = beat_count * bps / 2
            sustain = (chord_length_secs / bps) - 0.1
            for note in chord.notes
              osc = new Tone.Oscillator(note.freq, waveforms[i])
              # get gain level from decibels
              gain = osc.dbToGain($scope.composition.clefs[clef].decibels)
              # get decibels for gain divided by how many notes are playing
              decibels = osc.gainToDb(gain / chord.notes.length)
              # set volume in decibels
              osc.setVolume decibels
              # oscillator to master
              osc.toMaster()
              # start oscillator
              osc.start(0)
              # stop oscillator after sustain
              osc.stop("+" + sustain)

          # styling dom
          if typeof chord == "object"
            $('.' + clef + ' .beat.active').removeClass 'active'
            $('.' + clef + ' .beat.go').removeClass clef + '-go'
            $('.' + clef + ' .beat:nth-child(' + (index + 1) + ')').addClass clef + '-go'
          else if chord != 'sus'
            $('.' + clef + ' .beat.active').removeClass 'active'
            $('.' + clef + ' .beat.go').removeClass clef + '-go'



        # update index
        index = (index + 1) % beats
      # first call of next beat
      next_beat()
      # ms to relative speed (based on resolution)
      time = tempo_time / ($scope.composition.resolution / 4)
      # set interval for next beat to occur at approriate time
      performance_interval = window.setInterval(next_beat, time)

    # stop button
    $scope.stopPerformance = () ->
      $scope.playing = false
      window.clearInterval(performance_interval)

    # toggle performance
    $scope.togglePerformance = () ->
      if $scope.playing == true
        $scope.stopPerformance()
      else
        $scope.playPerformance()
]
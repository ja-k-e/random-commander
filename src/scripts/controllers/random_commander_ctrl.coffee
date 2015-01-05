app.controller 'RandomCommanderCtrl', [
  '$scope'
  'DataLibrary'
  'Performance'

  ($scope, DataLibrary, Performance) ->

    # data library
    $scope.library = DataLibrary

    # metronome
    $scope.metronome = false
    $scope.toggleMetronome = () ->
      $scope.metronome = !$scope.metronome

    # the composition
    $scope.composition = {
      measures: 12 # measures to generate
      tempo: 90 # tempo of performance
      beats: 4 # beats per measure
      resolution: 16 # smallest note
      root: 4 # root of key
      clefs: {
        treble: {
          values: [5,0,10,5,0,0,0,0,0]
          intervals: [10,0,0,5,0,0,0,5,0,0,5,0]
          chords: [10,5,5,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 6
          waveform: 'sawtooth'
          volume: 6
        }
        bass: {
          values: [10,10,10,10,0,0,0,0,0]
          intervals: [10,0,0,10,0,10,0,10,0,0,10,0]
          chords: [10,0,0,0,0]
          octaves: [0,10,0]
          silence: 0
          baseoctave: 3
          waveform: 'sawtooth'
          volume: 10
        }
      }
    }

    # getting first performance
    $scope.performance = Performance.getPerformance($scope.composition)

    # generate composition
    $scope.generatePerformance = () ->
      $scope.stopPerformance()
      $scope.performance = Performance.getPerformance($scope.composition)
    # console.log $scope.performance[0].length,$scope.performance[1].length

    # playing state
    $scope.playing = false
    # current step for view
    $scope.current_step = 0
    # clearing and playing performance interval
    performance_interval = undefined

    # progress variable
    $scope.progress = 0

    # play performance
    $scope.playPerformance = () ->
      $scope.playing = true
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

        $('.beat:nth-child(' + (index) + ')').addClass 'active'
        performance = $scope.performance
        for sequence, i in performance
          chord = sequence[index]
          if $scope.metronome && index % $scope.composition.beats == 0
            if index % ($scope.composition.beats * $scope.composition.beats) then freq = 3000 else freq = 4000
            metronome = new Tone.OmniOscillator(freq, 'pulse')
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
            waveforms = [$scope.composition.clefs.treble.waveform, $scope.composition.clefs.bass.waveform]
            decibels = [$scope.composition.clefs.treble.decibels, $scope.composition.clefs.bass.decibels]
            # beats per second
            bps = $scope.composition.tempo / 60
            # how much of a beat is the length
            beat_count = chord.length / 0.25
            # sustain of the note in seconds
            sustain = (beat_count * bps / 2) * 0.95

            notes_size = chord.notes.length

            chord_0 = performance[0][index]
            chord_1 = performance[1][index]
            if chord != chord_1 && (typeof chord_1 == "object")
              notes_size += chord_1.notes.length
            else if chord != chord_0 && (typeof chord_0 == "object")
              notes_size += chord_0.notes.length

            for note in chord.notes
              osc = new Tone.OmniOscillator(note.freq, waveforms[i])
              # get gain level from decibels
              gain = 0.1 * ($scope.composition.clefs[clef].volume / 10)
              # get decibels for gain divided by how many notes are playing
              decibels = osc.gainToDb((gain / notes_size) + gain)
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
      $('.beat.active').removeClass 'active'
      window.clearInterval(performance_interval)

    # toggle performance
    $scope.togglePerformance = () ->
      if $scope.playing == true
        $scope.stopPerformance()
      else
        $scope.playPerformance()
]
app.controller 'RandomCommanderCtrl', [
  '$scope'
  '$timeout'
  'DataLibrary'
  'Performance'
  'Presets'

  ($scope, $timeout, DataLibrary, Performance, Presets) ->

    # data library
    $scope.library = DataLibrary

    # metronome
    $scope.metronome = false
    $scope.toggleMetronome = () ->
      $scope.metronome = !$scope.metronome

    # menu
    $scope.menu = false
    $scope.toggleMenu = () ->
      $scope.menu = !$scope.menu

    # the composition
    $scope.presets = Presets
    $scope.composition = Presets.flutter

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
      composition = $scope.composition
      performance = $scope.performance
      # total beat count
      beats = composition.measures * composition.beats * composition.resolution / 4
      # relative index
      index = 0
      # tempo to ms
      tempo_time = 60000 / composition.tempo

      # single beat instance
      next_beat = () ->

        for sequence, i in performance
          chord = sequence[index]

          if $scope.metronome && index % (composition.resolution / 4) == 0
            if index == 0 || index / 4 % composition.beats == 0 then freq = 4100 else freq = 3000
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
            waveforms = [composition.clefs.treble.waveform, composition.clefs.bass.waveform]
            decibels = [composition.clefs.treble.decibels, composition.clefs.bass.decibels]
            # beats per second
            bps = composition.tempo / 60
            # how much of a beat is the length
            beat_count = chord.length / (1 / composition.resolution)
            # sustain of the note in seconds
            sustain = (beat_count * (bps * (1 / composition.resolution))) * 0.99

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
              gain = 0.1 * (composition.clefs[clef].volume / 10)
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
          selector = '.' + clef + ' .beat:nth-child(' + (index + 1) + ')'
          if chord != 'sus'
            $('.' + clef + ' .beat.active').removeClass 'active'
            $(selector).addClass 'active'

        # update index
        index = (index + 1) % beats
      # first call of next beat
      next_beat()
      # ms to relative speed (based on resolution)
      time = tempo_time / (composition.resolution / 4)
      # set interval for next beat to occur at appropriate time
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
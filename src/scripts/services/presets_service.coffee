app.service 'Presets', [ () ->
    return {
      flutter: {
        name: 'Flutter'
        measures: 4,tempo: 120, beats: 4, resolution: 16, root: 0
        clefs: {
          treble: {
            values: [0,0,0,0,10,0,0,0,0]
            intervals: [10,0,0,5,0,0,0,5,0,0,5,0]
            chords: [10,0,0,0,0]
            octaves: [5,10,5]
            silence: 0
            baseoctave: 6
            waveform: 'triangle'
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
      glory: {
        measures: 16, tempo: 120, beats: 4, resolution: 16, root: 4
        clefs: {
          treble: {
            values: [5,0,10,5,0,0,0,0,0]
            intervals: [10,0,0,5,0,0,0,5,0,0,5,0]
            chords: [10,5,5,0,0]
            octaves: [5,10,5]
            silence: 0
            baseoctave: 6
            waveform: 'sine'
            volume: 6
          }
          bass: {
            values: [10,10,10,10,0,0,0,0,0]
            intervals: [10,0,0,10,0,10,0,10,0,0,10,0]
            chords: [10,2,0,0,0]
            octaves: [5,10,3]
            silence: 0
            baseoctave: 3
            waveform: 'sawtooth'
            volume: 10
          }
        }
      }
    }
]
app.service 'Presets', [ () ->
  return {
    flutter: {
      name: 'Flutter'
      measures: 4,tempo: 120, beats: 4, resolution: 16, root: 0
      clefs: {
        treble: {
          values: [0,0,0,0,10]
          intervals: [10,0,0,10,0,6,0,10,4,0,5,0]
          chords: [10,0,0,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 6
          waveform: 'triangle'
          volume: 6
        }
        bass: {
          values: [10,10,10,10,0]
          intervals: [10,10,0,10,0,10,0,10,10,0,10,0]
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
      name: 'Glory'
      measures: 16, tempo: 120, beats: 4, resolution: 16, root: 7
      clefs: {
        treble: {
          values: [5,0,10,5,0]
          intervals: [10,0,0,5,0,0,0,5,0,0,5,0]
          chords: [10,5,5,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 6
          waveform: 'sine'
          volume: 6
        }
        bass: {
          values: [10,10,10,10,0]
          intervals: [10,0,0,10,0,10,0,10,0,0,10,0]
          chords: [10,0,0,0,0]
          octaves: [5,10,3]
          silence: 0
          baseoctave: 3
          waveform: 'triangle'
          volume: 10
        }
      }
    }
    magic: {
      name: 'Magic'
      measures: 4, tempo: 120, beats: 4, resolution: 16, root: 1
      clefs: {
        treble: {
          values: [5,5,5,5,5]
          intervals: [10,5,0,5,0,5,0,5,5,0,5,0]
          chords: [10,5,5,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 6
          waveform: 'triangle'
          volume: 6
        },
        bass: {
          values: [10,10,10,10,0]
          intervals: [10,5,0,10,0,10,0,10,5,0,10,0]
          chords: [10,0,0,0,0]
          octaves: [0,10,0]
          silence: 0
          baseoctave: 3
          waveform: 'triangle'
          volume: 10
        }
      }
    }
    jonny: {
      name: 'Jonny'
      measures: 1, tempo: 160, beats: 7, resolution: 16, root: 6
      clefs: {
        treble: {
          values: [0,0,0,0,10]
          intervals: [10,0,0,10,0,6,0,10,4,0,5,0]
          chords: [10,0,0,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 6
          waveform: 'sawtooth'
          volume: 6
        }
        bass: {
          values: [0,0,10,0,0]
          intervals: [10,0,0,10,0,6,0,10,4,0,5,0]
          chords: [10,0,0,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 5
          waveform: 'square'
          volume: 7
        }
      }
    }
  }
]
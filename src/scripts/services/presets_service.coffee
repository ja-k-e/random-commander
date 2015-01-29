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
    flicker: {
      name: 'Flicker'
      measures: 4,tempo: 100, beats: 5, resolution: 16, root: 6
      clefs: {
        treble: {
          values: [0,0,0,0,10]
          intervals: [10,0,5,0,10,0,0,10,0,5,0,10]
          chords: [0,10,5,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 6
          waveform: 'triangle'
          volume: 6
        }
        bass: {
          values: [10,10,0,0,0]
          intervals: [10,0,0,0,10,0,0,10,0,0,0,10]
          chords: [10,0,0,0,0]
          octaves: [0,10,0]
          silence: 0
          baseoctave: 5
          waveform: 'square'
          volume: 5
        }
      }
    }
    roulette: {
      name: 'Roulette', measures: 4, tempo: 150, beats: 4, resolution: 16, root: 1
      clefs: {
        treble: {
          values: [1,1,1,1,1]
          intervals: [1,1,1,1,1,1,1,1,1,1,1,1]
          chords: [1,1,1,1,1]
          octaves: [1,1,1]
          silence: 5
          baseoctave: 6
          waveform: 'triangle'
          volume: 6
        }
        bass: {
          values: [1,1,1,1,1]
          intervals: [1,1,1,1,1,1,1,1,1,1,1,1]
          chords: [1,1,1,1,1]
          octaves: [1,1,1]
          silence: 5
          baseoctave: 5
          waveform: 'triangle'
          volume: 6
        }
      }
    }
    thumper: {
      name: 'Thumper'
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
          values: [0,0,0,0,10]
          intervals: [10,0,0,10,0,10,0,10,0,0,10,0]
          chords: [10,0,0,0,0]
          octaves: [0,10,3]
          silence: 0
          baseoctave: 3
          waveform: 'triangle'
          volume: 10
        }
      }
    }
    wander: {
      name: 'Wander'
      measures: 4, tempo: 150, beats: 4, resolution: 16, root: 1
      clefs: {
        treble: {
          values: [5,5,5,5,5]
          intervals: [10,5,0,5,0,5,0,5,5,0,5,0]
          chords: [10,5,5,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 5
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
          waveform: 'sine'
          volume: 10
        }
      }
    }
    jonny: {
      name: 'Jonny'
      measures: 2, tempo: 160, beats: 7, resolution: 16, root: 6
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
          values: [0,0,10,0,0]
          intervals: [10,0,0,10,0,6,0,10,4,0,5,0]
          chords: [10,0,0,0,0]
          octaves: [5,10,5]
          silence: 0
          baseoctave: 5
          waveform: 'triangle'
          volume: 7
        }
      }
    }
  }
]
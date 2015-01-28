app.service 'DataLibrary', [ () ->
    return {
      resolutions: [
        {name: '1/4', value: 4}
        {name: '1/8', value: 8}
        {name: '1/16', value: 16}
      ]
      notes: [
        {name: 'C', value: 0}
        {name: 'C#', value: 1}
        {name: 'D', value: 2}
        {name: 'D#', value: 3}
        {name: 'E', value: 4}
        {name: 'F', value: 5}
        {name: 'F#', value: 6}
        {name: 'G', value: 7}
        {name: 'G#', value: 8}
        {name: 'A', value: 9}
        {name: 'A#', value: 10}
        {name: 'B', value: 11}
      ]
      silence: [
        {name: '0%', value: 0}
        {name: '10%', value: 1}
        {name: '20%', value: 2}
        {name: '30%', value: 3}
        {name: '40%', value: 4}
        {name: '50%', value: 5}
        {name: '60%', value: 6}
        {name: '70%', value: 7}
        {name: '80%', value: 8}
        {name: '90%', value: 9}
        {name: '100%', value: 10}
      ]
      values: [
        {name: 'Whole', size: 1/1, denominator: 1}
        {name: 'Half', size: 1/2, denominator: 2}
        {name: 'Quarter', size: 1/4, denominator: 4}
        {name: 'Eighth', size: 1/8, denominator: 8}
        {name: 'Sixteenth', size: 1/16, denominator: 16}
        {name: 'Dotted Half', size: 1/1.5, denominator: 1.5}
        {name: 'Dotted Quarter', size: 1/6, denominator: 6}
        {name: 'Dotted Eighth', size: 1/12, denominator: 12}
        {name: 'Dotted Sixteenth', size: 1/24, denominator: 24}
      ]
      intervals: [
        {name: 'Perfect Unison', interval: 1}
        {name: 'Minor Second', interval: 2}
        {name: 'Major Second', interval: 3}
        {name: 'Minor Third', interval: 4}
        {name: 'Major Third', interval: 5}
        {name: 'Perfect Fourth', interval: 6}
        {name: 'Tritone', interval: 7}
        {name: 'Perfect Fifth', interval: 8}
        {name: 'Minor Sixth', interval: 9}
        {name: 'Major Sixth', interval: 10}
        {name: 'Minor Seventh', interval: 11}
        {name: 'Major Seventh', interval: 12}
      ]
      # chord sizes
      chords: [
        {name: 'Monad', value: 1}
        {name: 'Dyad', value: 2}
        {name: 'Triad', value: 3}
        {name: 'Quartad', value: 4}
        {name: 'Pentad', value: 5}
      ]
      # relative octaves
      octaves: [
        {name: 'Low', value: 1}
        {name: 'Middle', value: 2}
        {name: 'High', value: 3}
      ]
      # base octaves
      baseoctaves: [
        {name: '1', value: 1}
        {name: '2', value: 2}
        {name: '3', value: 3}
        {name: '4', value: 4}
        {name: '5', value: 5}
        {name: '6', value: 6}
        {name: '7', value: 7}
        {name: '8', value: 8}
      ]
      # waveforms
      waveforms: [
        {name: 'Sine', value: 'sine' }
        {name: 'Square', value: 'square' }
        {name: 'Sawtooth', value: 'sawtooth' }
        {name: 'Triangle', value: 'triangle' }
        {name: 'Pulse', value: 'pulse' }
      ]
      # note frequencies array of octave arrays that start on C
      frequencies: [
        [16.351, 17.324, 18.354, 19.445, 20.601, 21.827, 23.124, 24.499, 25.956, 27.5, 29.135, 30.868]
        [32.703, 34.648, 36.708, 38.891, 41.203, 43.654, 46.249, 48.999, 51.913, 55, 58.27, 61.735]
        [65.406, 69.296, 73.416, 77.782, 82.407, 87.307, 92.499, 97.999, 103.826, 110, 116.541, 123.471]
        [130.813, 138.591, 146.832, 155.563, 164.814, 174.614, 184.997, 195.998, 207.652, 220, 233.082, 246.942]
        [261.626, 277.183, 293.665, 311.127, 329.628, 349.228, 369.994, 391.995, 415.305, 440, 466.164, 493.883]
        [523.251, 554.365, 587.33, 622.254, 659.255, 698.456, 739.989, 783.991, 830.609, 880, 932.328, 987.767]
        [1046.502, 1108.731, 1174.659, 1244.508, 1318.51, 1396.913, 1479.978, 1567.982, 1661.219, 1760, 1864.655, 1975.533]
        [2093.005, 2217.461, 2349.318, 2489.016, 2637.021, 2793.826, 2959.955, 3135.964, 3322.438, 3520, 3729.31, 3951.066]
        [4186.009, 4434.922, 4698.636, 4978.032, 5274.042, 5587.652, 5919.91, 6271.928, 6644.876, 7040, 7458.62, 7902.132]
        [8372.018, 8869.844, 9397.272, 9956.064, 10548.084, 11175.304, 11839.82, 12543.856, 13289.752, 14080, 14917.24, 15804.264]
      ]
   }
]
app.service 'DataLibrary', [ () ->
    return {
      resolutions: [
        {name: '1/4', value: 1/4}
        {name: '1/8', value: 1/8}
        {name: '1/16', value: 1/16}
        {name: '1/32', value: 1/32}
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
      values: [
        {name: 'Whole', size: 1/1, denominator: 1}
        {name: 'Half', size: 1/2, denominator: 2}
        {name: 'Quarter', size: 1/4, denominator: 4}
        {name: 'Eighth', size: 1/8, denominator: 8}
        {name: 'Sixteenth', size: 1/16, denominator: 16}
        {name: 'Thirty-second', size: 1/32, denominator: 32}
        {name: 'Dotted Half', size: 1/1.5, denominator: 1.5}
        {name: 'Dotted Quarter', size: 1/6, denominator: 6}
        {name: 'Dotted Eighth', size: 1/12, denominator: 12}
        {name: 'Dotted Sixteenth', size: 1/24, denominator: 24}
      ]
      intervals: [
        {name: 'Perfect Unison', interval: 0}
        {name: 'Minor Second', interval: 1}
        {name: 'Major Second', interval: 2}
        {name: 'Minor Third', interval: 3}
        {name: 'Major Third', interval: 4}
        {name: 'Perfect Fourth', interval: 5}
        {name: 'Tritone', interval: 6}
        {name: 'Perfect Fifth', interval: 7}
        {name: 'Minor Sixth', interval: 8}
        {name: 'Major Sixth', interval: 9}
        {name: 'Minor Seventh', interval: 10}
        {name: 'Major Seventh', interval: 11}
      ]
      chords: [
        {name: '1 Note', size: 1}
        {name: '2 Notes', size: 2}
        {name: '3 Notes', size: 3}
        {name: '4 Notes', size: 4}
        {name: '5 Notes', size: 5}
      ]
      octaves: [
        {name: 'Lower', size: 1}
        {name: 'Middle', size: 2}
        {name: 'Higher', size: 3}
      ]
   }
]
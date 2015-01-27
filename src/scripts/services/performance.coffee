app.service 'Performance', [

  'DataLibrary'

  (DataLibrary) ->

    getPerformance: (composition) ->

      chordContainsFreq = (freq, notes) ->
        for note in notes
          if note.freq == freq then return true
        return false

      # generate a package of chances and values based on an object containing multiple possible zero values
      ChancePkg = (vals, key) ->
        # generating vals and their chances of occurring
        new_vals = []
        # get total number of vals
        vals_count = 0
        for value, i in vals
          if value > 0
            vals_count += value
            new_vals.push [DataLibrary[key][i], value]
        # go through new vals and generate chance for each value
        new_vals_chances = []
        total = 0
        for val, i in new_vals
          # relative amount for random selection
          amount = total + ( (val[1] / vals_count ) * 100000)
          # round up for last value
          if i + 1 == new_vals.length then amount = 100000
          # push amount into chances array
          new_vals_chances.push amount
          # increase base total
          total = amount
        # return package which has array for both non-zero vals and their corrosponding chance
        return {chances: new_vals_chances, vals: new_vals}


      # get random val from chance package
      randomVal = (chance_pkg) ->
        random = Math.random() * 100000
        for chance, i in chance_pkg.chances
          return chance_pkg.vals[i] if random < chance
        return


      # get the duration in smallest resolution amount
      duration = composition.measures * (composition.beats * (composition.resolution / 4))
      # future sequences
      sequences = []

      for index of composition.clefs
        # clef is the object, index is the clef name
        clef = composition.clefs[index]
        # note sequence
        sequence = []
        # temp duration
        temp_duration = duration


        # value package has array for both non-zero values and their corrosponding chance
        clef.values_pkg = new ChancePkg(clef.values, 'values')
        # interval package has array for both non-zero intervals and their corrosponding chance
        clef.intervals_pkg = new ChancePkg(clef.intervals, 'intervals')
        # octaves package has array for both non-zero octaves and their corrosponding chance
        clef.octaves_pkg = new ChancePkg(clef.octaves, 'octaves')
        # chords package has array for both non-zero chords and their corrosponding chance
        clef.chords_pkg = new ChancePkg(clef.chords, 'chords')


        # while there is still duration
        while temp_duration > 0
          # random hit
          random = Math.random() * 10

          # if a hit
          if random > clef.silence
            # random chord note count
            chord = randomVal(clef.chords_pkg)[0]["value"]
            # random length for the chord
            value = randomVal(clef.values_pkg)[0]["denominator"]
            # note length
            note_length = 1 / value
            # step size
            step_length = 1 / composition.resolution

            # if there isnt enough space
            if note_length / step_length >= temp_duration
              # make it the length of remaining
              value = ((1 / temp_duration) / step_length)
              note_length = 1 / value

            # the new chord
            note_width = 95 * Math.floor((note_length / step_length))
            new_chord = {length: note_length, note_width: note_width, notes: []}
            # console.log value, new_chord.length / (1 / composition.resolution)
            # for each note in the chord
            temp_freqs = []
            while new_chord.notes.length < chord
              # get a random interval
              interval = randomVal(clef.intervals_pkg)[0]["interval"]
              # get the random octave
              octave = randomVal(clef.octaves_pkg)[0]["value"]

              # make interval relative to key
              interval += composition.root
              # if key pushes interval into new octave
              if interval > 12
                interval -= 12
              # make the octave relative to the clef's octave
              new_octave = clef.baseoctave + ((2 - octave) * -1)
              # the frequency of the note
              note = DataLibrary.frequencies[new_octave - 1][interval]
              # calculate top
              top = 100 - (interval + (12 * (octave - 1))) / 36 * 100
              # if note doesnt already exist in chord
              new_note = {freq: note, int: interval, octave: octave, top: top}
              if temp_freqs.indexOf(note) == -1
                temp_freqs.push note
                # push the frequency into the chord's notes
                new_chord.notes.push new_note
              # else
                # duplicate note in chord, ignoring it for now.
                # console.log 'duplicate note in chord, ignoring it for now.'

            # push the chord into the sequence
            sequence.push new_chord
            # get values resolution-relative value
            res_value = Math.floor((1 / value) / (1 / composition.resolution))
            # if we need to add sustain notes
            if res_value > 1
              # add blank values
              for blank in [1..res_value - 1]
                sequence.push 'sus'
            # subtract from the temp_duration
            temp_duration -= res_value

          else
            # it was a miss, add a zero to the sequence
            sequence.push 0
            # subtract tick from temp_duration
            temp_duration--
        sequences.push sequence

      return sequences
]
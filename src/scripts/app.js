(function() {
  var app;

  app = angular.module('RandomCommander', ['ngAnimate']);

  app.controller('DisplayCtrl', ['$scope', function($scope) {}]);

  app.controller('EditorCtrl', [
    '$scope', function($scope) {
      $scope.view = {
        group: 'global'
      };
      $scope.updateComposition = function(val) {
        $scope.$parent.composition = val;
        return $scope.$parent.generatePerformance();
      };
      return $scope.editor = $scope.$parent.editor;
    }
  ]);

  app.controller('RandomCommanderCtrl', [
    '$scope', '$timeout', 'DataLibrary', 'Performance', 'Presets', function($scope, $timeout, DataLibrary, Performance, Presets) {
      var performance_interval;
      $scope.library = DataLibrary;
      $scope.metronome = false;
      $scope.toggleMetronome = function() {
        return $scope.metronome = !$scope.metronome;
      };
      $scope.menu = false;
      $scope.toggleMenu = function() {
        return $scope.menu = !$scope.menu;
      };
      $scope.presets = Presets;
      $scope.composition = Presets.flutter;
      $scope.performance = Performance.getPerformance($scope.composition);
      $scope.generatePerformance = function() {
        $scope.stopPerformance();
        return $scope.performance = Performance.getPerformance($scope.composition);
      };
      $scope.playing = false;
      $scope.current_step = 0;
      performance_interval = void 0;
      $scope.progress = 0;
      $scope.playPerformance = function() {
        var beats, composition, index, next_beat, performance, tempo_time, time;
        $scope.playing = true;
        composition = $scope.composition;
        performance = $scope.performance;
        beats = composition.measures * composition.beats * composition.resolution / 4;
        index = 0;
        tempo_time = 60000 / composition.tempo;
        next_beat = function() {
          var beat_count, bps, chord, chord_0, chord_1, clef, decibels, freq, gain, i, metronome, note, notes_size, osc, selector, sequence, sustain, waveforms, _i, _j, _len, _len1, _ref;
          for (i = _i = 0, _len = performance.length; _i < _len; i = ++_i) {
            sequence = performance[i];
            chord = sequence[index];
            if ($scope.metronome && index % (composition.resolution / 4) === 0) {
              if (index === 0 || index / 4 % composition.beats === 0) {
                freq = 4100;
              } else {
                freq = 3000;
              }
              metronome = new Tone.OmniOscillator(freq, 'pulse');
              metronome.setVolume(-30);
              metronome.toMaster();
              metronome.start(0);
              metronome.stop("+16n");
            }
            if (i === 0) {
              clef = 'treble';
            } else {
              clef = 'bass';
            }
            if (typeof chord === "object") {
              waveforms = [];
              decibels = [];
              if (composition.clefs.treble) {
                waveforms.push(composition.clefs.treble.waveform);
                decibels.push(composition.clefs.treble.decibels);
              }
              if (composition.clefs.bass) {
                waveforms.push(composition.clefs.bass.waveform);
                decibels.push(composition.clefs.bass.decibels);
              }
              bps = composition.tempo / 60;
              beat_count = chord.length / (1 / composition.resolution);
              sustain = (beat_count * (bps * (1 / composition.resolution))) * 0.99;
              notes_size = chord.notes.length;
              chord_0 = performance[0][index];
              chord_1 = performance[1] ? performance[1][index] : null;
              if (chord_1 && chord !== chord_1 && (typeof chord_1 === "object")) {
                notes_size += chord_1.notes.length;
              } else if (chord !== chord_0 && (typeof chord_0 === "object")) {
                notes_size += chord_0.notes.length;
              }
              _ref = chord.notes;
              for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
                note = _ref[_j];
                osc = new Tone.OmniOscillator(note.freq, waveforms[i]);
                gain = 0.1 * (composition.clefs[clef].volume / 10);
                decibels = osc.gainToDb((gain / notes_size) + gain);
                osc.setVolume(decibels);
                osc.toMaster();
                osc.start(0);
                osc.stop("+" + sustain);
              }
            }
            selector = '.' + clef + ' .beat:nth-child(' + (index + 1) + ')';
            if (chord !== 'sus') {
              $('.' + clef + ' .beat.active').removeClass('active');
              $(selector).addClass('active');
            }
          }
          return index = (index + 1) % beats;
        };
        next_beat();
        time = tempo_time / (composition.resolution / 4);
        return performance_interval = window.setInterval(next_beat, time);
      };
      $scope.stopPerformance = function() {
        $scope.playing = false;
        $('.beat.active').removeClass('active');
        return window.clearInterval(performance_interval);
      };
      return $scope.togglePerformance = function() {
        if ($scope.playing === true) {
          return $scope.stopPerformance();
        } else {
          return $scope.playPerformance();
        }
      };
    }
  ]);

  app.directive("gridOptions", [
    '$interval', function($interval) {
      return {
        templateUrl: 'templates/grid-options.html',
        scope: {
          model: '=',
          options: '=',
          label: '@',
          groupname: '@'
        },
        link: function(scope, elm, attrs) {
          return scope.select = function(option) {
            return scope.model = option.value;
          };
        }
      };
    }
  ]);

  app.directive("jsonPaster", [
    function() {
      return {
        templateUrl: 'templates/json-paster.html',
        scope: {
          model: '=',
          label: '@'
        },
        link: function(scope, elm, attrs) {
          return scope.update = function() {
            return scope.model = JSON.parse(elm.find('textarea').val());
          };
        }
      };
    }
  ]);

  app.directive("numberSwitch", [
    '$interval', function($interval) {
      return {
        templateUrl: 'templates/number-switch.html',
        scope: {
          model: '=',
          min: '@',
          max: '@',
          step: '@',
          label: '@'
        },
        link: function(scope, elm, attrs) {
          var change, promise;
          promise = void 0;
          change = function(base, direction) {
            var max, min, new_val, step;
            step = scope.$eval(scope.step || 1);
            min = scope.$eval(scope.min || 0);
            max = scope.$eval(scope.max || Infinity);
            if (direction === '+') {
              new_val = base + step <= max ? base + step : base;
              return scope.model = new_val;
            } else if (direction === '-') {
              new_val = base - step >= min ? base - step : base;
              return scope.model = new_val;
            } else {
              return console.log('no direction provided');
            }
          };
          scope.changeClick = function(direction) {
            return change(scope.model, direction);
          };
          return scope.validate = function(min, max) {
            var float;
            min = scope.$eval(attrs.min || 0);
            max = scope.$eval(attrs.max || Infinity);
            float = parseFloat(scope.model);
            if (isNaN(float) || float === void 0) {
              return scope.model = parseFloat(min);
            } else if (scope.model < min) {
              return scope.model = parseFloat(min);
            } else if (scope.model > max) {
              return scope.model = parseFloat(max);
            } else {
              return scope.model = float;
            }
          };
        }
      };
    }
  ]);

  app.service('DataLibrary', [
    function() {
      return {
        resolutions: [
          {
            name: '1/4',
            value: 4
          }, {
            name: '1/8',
            value: 8
          }, {
            name: '1/16',
            value: 16
          }
        ],
        notes: [
          {
            name: 'C',
            value: 0
          }, {
            name: 'C#',
            value: 1
          }, {
            name: 'D',
            value: 2
          }, {
            name: 'D#',
            value: 3
          }, {
            name: 'E',
            value: 4
          }, {
            name: 'F',
            value: 5
          }, {
            name: 'F#',
            value: 6
          }, {
            name: 'G',
            value: 7
          }, {
            name: 'G#',
            value: 8
          }, {
            name: 'A',
            value: 9
          }, {
            name: 'A#',
            value: 10
          }, {
            name: 'B',
            value: 11
          }
        ],
        silence: [
          {
            name: '0%',
            value: 0
          }, {
            name: '10%',
            value: 1
          }, {
            name: '20%',
            value: 2
          }, {
            name: '30%',
            value: 3
          }, {
            name: '40%',
            value: 4
          }, {
            name: '50%',
            value: 5
          }, {
            name: '60%',
            value: 6
          }, {
            name: '70%',
            value: 7
          }, {
            name: '80%',
            value: 8
          }, {
            name: '90%',
            value: 9
          }, {
            name: '100%',
            value: 10
          }
        ],
        values: [
          {
            name: 'Whole',
            size: 1 / 1,
            denominator: 1
          }, {
            name: 'Half',
            size: 1 / 2,
            denominator: 2
          }, {
            name: 'Quarter',
            size: 1 / 4,
            denominator: 4
          }, {
            name: 'Eighth',
            size: 1 / 8,
            denominator: 8
          }, {
            name: 'Sixteenth',
            size: 1 / 16,
            denominator: 16
          }
        ],
        intervals: [
          {
            name: 'Perfect Unison',
            interval: 1
          }, {
            name: 'Minor Second',
            interval: 2
          }, {
            name: 'Major Second',
            interval: 3
          }, {
            name: 'Minor Third',
            interval: 4
          }, {
            name: 'Major Third',
            interval: 5
          }, {
            name: 'Perfect Fourth',
            interval: 6
          }, {
            name: 'Tritone',
            interval: 7
          }, {
            name: 'Perfect Fifth',
            interval: 8
          }, {
            name: 'Minor Sixth',
            interval: 9
          }, {
            name: 'Major Sixth',
            interval: 10
          }, {
            name: 'Minor Seventh',
            interval: 11
          }, {
            name: 'Major Seventh',
            interval: 12
          }
        ],
        chords: [
          {
            name: 'Monad',
            value: 1
          }, {
            name: 'Dyad',
            value: 2
          }, {
            name: 'Triad',
            value: 3
          }, {
            name: 'Quartad',
            value: 4
          }, {
            name: 'Pentad',
            value: 5
          }
        ],
        octaves: [
          {
            name: 'Low',
            value: 1
          }, {
            name: 'Middle',
            value: 2
          }, {
            name: 'High',
            value: 3
          }
        ],
        baseoctaves: [
          {
            name: '1',
            value: 1
          }, {
            name: '2',
            value: 2
          }, {
            name: '3',
            value: 3
          }, {
            name: '4',
            value: 4
          }, {
            name: '5',
            value: 5
          }, {
            name: '6',
            value: 6
          }, {
            name: '7',
            value: 7
          }, {
            name: '8',
            value: 8
          }
        ],
        waveforms: [
          {
            name: 'Sine',
            value: 'sine'
          }, {
            name: 'Square',
            value: 'square'
          }, {
            name: 'Sawtooth',
            value: 'sawtooth'
          }, {
            name: 'Triangle',
            value: 'triangle'
          }, {
            name: 'Pulse',
            value: 'pulse'
          }
        ],
        frequencies: [[16.351, 17.324, 18.354, 19.445, 20.601, 21.827, 23.124, 24.499, 25.956, 27.5, 29.135, 30.868], [32.703, 34.648, 36.708, 38.891, 41.203, 43.654, 46.249, 48.999, 51.913, 55, 58.27, 61.735], [65.406, 69.296, 73.416, 77.782, 82.407, 87.307, 92.499, 97.999, 103.826, 110, 116.541, 123.471], [130.813, 138.591, 146.832, 155.563, 164.814, 174.614, 184.997, 195.998, 207.652, 220, 233.082, 246.942], [261.626, 277.183, 293.665, 311.127, 329.628, 349.228, 369.994, 391.995, 415.305, 440, 466.164, 493.883], [523.251, 554.365, 587.33, 622.254, 659.255, 698.456, 739.989, 783.991, 830.609, 880, 932.328, 987.767], [1046.502, 1108.731, 1174.659, 1244.508, 1318.51, 1396.913, 1479.978, 1567.982, 1661.219, 1760, 1864.655, 1975.533], [2093.005, 2217.461, 2349.318, 2489.016, 2637.021, 2793.826, 2959.955, 3135.964, 3322.438, 3520, 3729.31, 3951.066], [4186.009, 4434.922, 4698.636, 4978.032, 5274.042, 5587.652, 5919.91, 6271.928, 6644.876, 7040, 7458.62, 7902.132], [8372.018, 8869.844, 9397.272, 9956.064, 10548.084, 11175.304, 11839.82, 12543.856, 13289.752, 14080, 14917.24, 15804.264]]
      };
    }
  ]);

  app.service('Performance', [
    'DataLibrary', function(DataLibrary) {
      return {
        getPerformance: function(composition) {
          var ChancePkg, blank, chord, chordContainsFreq, clef, duration, index, interval, new_chord, new_note, new_octave, note, note_decimal, note_length, note_whole, note_width, octave, random, randomVal, res_value, sequence, sequences, step_length, temp_duration, temp_freqs, value, _i, _ref;
          chordContainsFreq = function(freq, notes) {
            var note, _i, _len;
            for (_i = 0, _len = notes.length; _i < _len; _i++) {
              note = notes[_i];
              if (note.freq === freq) {
                return true;
              }
            }
            return false;
          };
          ChancePkg = function(vals, key) {
            var amount, i, new_vals, new_vals_chances, total, val, vals_count, value, _i, _j, _len, _len1;
            new_vals = [];
            vals_count = 0;
            for (i = _i = 0, _len = vals.length; _i < _len; i = ++_i) {
              value = vals[i];
              if (value > 0) {
                vals_count += value;
                new_vals.push([DataLibrary[key][i], value]);
              }
            }
            new_vals_chances = [];
            total = 0;
            for (i = _j = 0, _len1 = new_vals.length; _j < _len1; i = ++_j) {
              val = new_vals[i];
              amount = total + ((val[1] / vals_count) * 100000);
              if (i + 1 === new_vals.length) {
                amount = 100000;
              }
              new_vals_chances.push(amount);
              total = amount;
            }
            return {
              chances: new_vals_chances,
              vals: new_vals
            };
          };
          randomVal = function(chance_pkg) {
            var chance, i, random, _i, _len, _ref;
            random = Math.random() * 100000;
            _ref = chance_pkg.chances;
            for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
              chance = _ref[i];
              if (random < chance) {
                return chance_pkg.vals[i];
              }
            }
          };
          duration = composition.measures * (composition.beats * (composition.resolution / 4));
          sequences = [];
          for (index in composition.clefs) {
            clef = composition.clefs[index];
            sequence = [];
            temp_duration = duration;
            clef.values_pkg = new ChancePkg(clef.values, 'values');
            clef.intervals_pkg = new ChancePkg(clef.intervals, 'intervals');
            clef.octaves_pkg = new ChancePkg(clef.octaves, 'octaves');
            clef.chords_pkg = new ChancePkg(clef.chords, 'chords');
            while (temp_duration > 0) {
              random = Math.random() * 10;
              if (random > clef.silence) {
                chord = randomVal(clef.chords_pkg)[0]["value"];
                value = randomVal(clef.values_pkg)[0]["denominator"];
                note_length = 1 / value;
                step_length = 1 / composition.resolution;
                if (note_length / step_length >= temp_duration) {
                  value = (1 / temp_duration) / step_length;
                  note_length = 1 / value;
                }
                note_whole = Math.floor(note_length / step_length);
                note_decimal = Math.floor((note_length / step_length - note_whole) * 100);
                note_width = note_whole + '_' + note_decimal;
                new_chord = {
                  length: note_length,
                  note_width: note_width,
                  notes: []
                };
                temp_freqs = [];
                while (new_chord.notes.length < chord) {
                  interval = randomVal(clef.intervals_pkg)[0]["interval"];
                  octave = randomVal(clef.octaves_pkg)[0]["value"];
                  interval += composition.root;
                  if (interval > 12) {
                    interval -= 12;
                  }
                  new_octave = clef.baseoctave + ((2 - octave) * -1);
                  note = DataLibrary.frequencies[new_octave - 1][interval - 1];
                  new_note = {
                    freq: note,
                    int: interval,
                    octave: octave
                  };
                  if (temp_freqs.indexOf(note) === -1) {
                    temp_freqs.push(note);
                    new_chord.notes.push(new_note);
                  }
                }
                sequence.push(new_chord);
                res_value = Math.floor((1 / value) / (1 / composition.resolution));
                if (res_value > 1) {
                  for (blank = _i = 1, _ref = res_value - 1; 1 <= _ref ? _i <= _ref : _i >= _ref; blank = 1 <= _ref ? ++_i : --_i) {
                    sequence.push('sus');
                  }
                }
                temp_duration -= res_value;
              } else {
                sequence.push(0);
                temp_duration--;
              }
            }
            sequences.push(sequence);
          }
          return sequences;
        }
      };
    }
  ]);

  app.service('Presets', [
    function() {
      return {
        flutter: {
          name: 'Flutter',
          measures: 4,
          tempo: 120,
          beats: 4,
          resolution: 16,
          root: 0,
          clefs: {
            treble: {
              values: [0, 0, 0, 0, 10],
              intervals: [10, 0, 0, 10, 0, 6, 0, 10, 4, 0, 5, 0],
              chords: [10, 0, 0, 0, 0],
              octaves: [5, 10, 5],
              silence: 0,
              baseoctave: 6,
              waveform: 'triangle',
              volume: 6
            },
            bass: {
              values: [10, 10, 10, 10, 0],
              intervals: [10, 10, 0, 10, 0, 10, 0, 10, 10, 0, 10, 0],
              chords: [10, 0, 0, 0, 0],
              octaves: [0, 10, 0],
              silence: 0,
              baseoctave: 3,
              waveform: 'sawtooth',
              volume: 10
            }
          }
        },
        glory: {
          name: 'Glory',
          measures: 16,
          tempo: 120,
          beats: 4,
          resolution: 16,
          root: 7,
          clefs: {
            treble: {
              values: [5, 0, 10, 5, 0],
              intervals: [10, 0, 0, 5, 0, 0, 0, 5, 0, 0, 5, 0],
              chords: [10, 5, 5, 0, 0],
              octaves: [5, 10, 5],
              silence: 0,
              baseoctave: 6,
              waveform: 'sine',
              volume: 6
            },
            bass: {
              values: [10, 10, 10, 10, 0],
              intervals: [10, 0, 0, 10, 0, 10, 0, 10, 0, 0, 10, 0],
              chords: [10, 0, 0, 0, 0],
              octaves: [5, 10, 3],
              silence: 0,
              baseoctave: 3,
              waveform: 'triangle',
              volume: 10
            }
          }
        },
        magic: {
          name: 'Magic',
          measures: 4,
          tempo: 120,
          beats: 4,
          resolution: 16,
          root: 1,
          clefs: {
            treble: {
              values: [5, 5, 5, 5, 5],
              intervals: [10, 5, 0, 5, 0, 5, 0, 5, 5, 0, 5, 0],
              chords: [10, 5, 5, 0, 0],
              octaves: [5, 10, 5],
              silence: 0,
              baseoctave: 6,
              waveform: 'triangle',
              volume: 6
            },
            bass: {
              values: [10, 10, 10, 10, 0],
              intervals: [10, 5, 0, 10, 0, 10, 0, 10, 5, 0, 10, 0],
              chords: [10, 0, 0, 0, 0],
              octaves: [0, 10, 0],
              silence: 0,
              baseoctave: 3,
              waveform: 'triangle',
              volume: 10
            }
          }
        },
        jonny: {
          name: 'Jonny',
          measures: 1,
          tempo: 160,
          beats: 7,
          resolution: 16,
          root: 6,
          clefs: {
            treble: {
              values: [0, 0, 0, 0, 10],
              intervals: [10, 0, 0, 10, 0, 6, 0, 10, 4, 0, 5, 0],
              chords: [10, 0, 0, 0, 0],
              octaves: [5, 10, 5],
              silence: 0,
              baseoctave: 6,
              waveform: 'sawtooth',
              volume: 6
            },
            bass: {
              values: [0, 0, 10, 0, 0],
              intervals: [10, 0, 0, 10, 0, 6, 0, 10, 4, 0, 5, 0],
              chords: [10, 0, 0, 0, 0],
              octaves: [5, 10, 5],
              silence: 0,
              baseoctave: 5,
              waveform: 'square',
              volume: 7
            }
          }
        }
      };
    }
  ]);

}).call(this);

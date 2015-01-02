(function() {
  var app;

  app = angular.module('RandomCommander', []);

  app.controller('DisplayCtrl', ['$scope', function($scope) {}]);

  app.controller('EditorCtrl', [
    '$scope', function($scope) {
      $scope.view = {
        t_data: 'tone',
        b_data: 'tone'
      };
      return $scope.dataRow = function(data, clef) {
        if (clef === 't') {
          return $scope.view.t_data = data;
        } else if (clef === 'b') {
          return $scope.view.b_data = data;
        } else {
          return $scope.view.t_data = data;
        }
      };
    }
  ]);

  app.controller('RandomCommanderCtrl', [
    '$scope', 'DataLibrary', 'Performance', function($scope, DataLibrary, Performance) {
      $scope.library = DataLibrary;
      $scope.composition = {
        measures: 12,
        tempo: 120,
        beats: 4,
        resolution: 16,
        root: 5,
        clefs: {
          treble: {
            values: [0, 0, 10, 5, 0, 0, 0, 0, 0, 0],
            intervals: [10, 0, 0, 5, 0, 0, 5, 0, 0, 0, 5, 0],
            chords: [10, 5, 0, 0, 0],
            octaves: [5, 10, 5],
            silence: 5,
            baseoctave: 5,
            waveform: 'sine',
            decibles: -4
          },
          bass: {
            values: [0, 0, 10, 5, 0, 0, 0, 0, 0, 0],
            intervals: [10, 0, 0, 5, 0, 0, 5, 0, 0, 0, 5, 0],
            chords: [10, 5, 0, 0, 0],
            octaves: [5, 10, 5],
            silence: 5,
            baseoctave: 3,
            waveform: 'sine',
            decibles: -4
          }
        }
      };
      $scope.performance = Performance.getPerformance($scope.composition);
      console.log($scope.performance);
      return $scope.generateComposition = function() {
        var composition, osc, osc2, performance, transport;
        composition = $scope.composition;
        performance = $scope.performance;
        transport = new Tone.Transport();
        transport.setBpm(composition.tempo);
        Tone.Transport.setInterval(function(time) {
          return envelope.triggerAttack(time);
        }, composition.resolution + "n");
        osc = new Tone.Oscillator(440, "sine");
        osc2 = new Tone.Oscillator(840, "sine");
        osc.setVolume(-24.0);
        osc2.setVolume(-24.0);
        osc.toMaster();
        osc2.toMaster();
        osc.start(0);
        osc2.start(0);
        osc.stop("+4n");
        osc2.stop("+4n");
        return transport.start();
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
          }, {
            name: '1/32',
            value: 32
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
          }, {
            name: 'Thirty-second',
            size: 1 / 32,
            denominator: 32
          }, {
            name: 'Dotted Half',
            size: 1 / 1.5,
            denominator: 1.5
          }, {
            name: 'Dotted Quarter',
            size: 1 / 6,
            denominator: 6
          }, {
            name: 'Dotted Eighth',
            size: 1 / 12,
            denominator: 12
          }, {
            name: 'Dotted Sixteenth',
            size: 1 / 24,
            denominator: 24
          }
        ],
        intervals: [
          {
            name: 'Perfect Unison',
            interval: 0
          }, {
            name: 'Minor Second',
            interval: 1
          }, {
            name: 'Major Second',
            interval: 2
          }, {
            name: 'Minor Third',
            interval: 3
          }, {
            name: 'Major Third',
            interval: 4
          }, {
            name: 'Perfect Fourth',
            interval: 5
          }, {
            name: 'Tritone',
            interval: 6
          }, {
            name: 'Perfect Fifth',
            interval: 7
          }, {
            name: 'Minor Sixth',
            interval: 8
          }, {
            name: 'Major Sixth',
            interval: 9
          }, {
            name: 'Minor Seventh',
            interval: 10
          }, {
            name: 'Major Seventh',
            interval: 11
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
          return {
            moo: 'oink'
          };
        }
      };
    }
  ]);

}).call(this);

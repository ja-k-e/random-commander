(function() {
  var app;

  app = angular.module('RandomCommander', []);

  app.controller('DataCtrl', [
    '$scope', 'DataLibrary', function($scope, DataLibrary) {
      $scope.library = DataLibrary;
      $scope.composition = {
        measures: 12,
        tempo: 120,
        beats: 4,
        resolution: 1 / 16,
        root: 5
      };
      $scope.treble = {
        values: [0, 0, 10, 5, 0, 0, 0, 0, 0, 0],
        intervals: [10, 0, 0, 5, 0, 0, 5, 0, 0, 0, 5, 0],
        chords: [10, 5, 0, 0, 0],
        octaves: [5, 10, 5]
      };
      $scope.bass = {
        values: [0, 0, 10, 5, 0, 0, 0, 0, 0, 0],
        intervals: [10, 0, 0, 5, 0, 0, 5, 0, 0, 0, 5, 0],
        chords: [10, 5, 0, 0, 0],
        octaves: [5, 10, 5]
      };
      $scope.view = {
        t_data: 'values',
        b_data: 'values'
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

  app.controller('DisplayCtrl', ['$scope', function($scope) {}]);

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
          scope.changeMouseDown = function(direction) {};
          scope.changeMouseUp = function() {};
          return scope.validate = function(min, max) {
            var float;
            min = scope.$eval(attrs.min || 0);
            max = scope.$eval(attrs.max || Infinity);
            float = parseFloat(scope.model);
            if (isNaN(float) || float === void 0) {
              return scope.model = min;
            } else if (scope.model < min) {
              return scope.model = min;
            } else if (scope.model > max) {
              return scope.model = max;
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
            value: 1 / 4
          }, {
            name: '1/8',
            value: 1 / 8
          }, {
            name: '1/16',
            value: 1 / 16
          }, {
            name: '1/32',
            value: 1 / 32
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
            name: '1 Note',
            size: 1
          }, {
            name: '2 Notes',
            size: 2
          }, {
            name: '3 Notes',
            size: 3
          }, {
            name: '4 Notes',
            size: 4
          }, {
            name: '5 Notes',
            size: 5
          }
        ],
        octaves: [
          {
            name: 'Lower',
            size: 1
          }, {
            name: 'Middle',
            size: 2
          }, {
            name: 'Higher',
            size: 3
          }
        ]
      };
    }
  ]);

}).call(this);

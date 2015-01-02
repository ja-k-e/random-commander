app.directive "numberSwitch", [
  '$interval'

  ($interval) ->
    templateUrl: 'templates/number-switch.html'
    scope: {
      model: '='
      min: '@'
      max: '@'
      step: '@'
      label: '@'
    }
    link: (scope, elm, attrs) ->
      # promise for interval
      promise = undefined
      # change the value based on the direction provided
      change = (base, direction) ->
        # how much to step
        step = scope.$eval scope.step || 1
        # minimum amount
        min = scope.$eval scope.min || 0
        # maximum amount
        max = scope.$eval scope.max || Infinity
        # if going up
        if direction == '+'
          new_val = if base + step <= max then base + step else base
          scope.model = new_val
        # if going down
        else if direction == '-'
          new_val = if base - step >= min then base - step else base
          scope.model = new_val
        # if you're an idiot
        else
          console.log 'no direction provided'

      # on click
      scope.changeClick = (direction) ->
        change(scope.model, direction)

      # on blur, validate whatever was typed in
      scope.validate = (min, max) ->
        min = scope.$eval attrs.min || 0
        max = scope.$eval attrs.max || Infinity
        # if random characters
        float = parseFloat scope.model
        if isNaN(float) || float == undefined
          scope.model = parseFloat min
        # if too small
        else if scope.model < min
          scope.model = parseFloat  min
        # if too big
        else if scope.model > max
          scope.model = parseFloat max
        # it is right
        else
          scope.model = float

]
angular.module 'psp', []
angular.module 'psp.combodate', []

angular.module 'psp.combodate'
  .directive 'pspCombodate', (defaultDateFormat) ->
    restrict: 'A'
    require: 'ngModel'
    scope:
      # causes some problems if it's ony called disabled :(
      pspDisabled: "="
      format: '@'
      template: '@'
      value: '='
      minYear: '@'
      maxYear: '@'
      yearDescending: '@'
      minuteStep: '@'
      secondStep: '@'
      firstItem: '@'
      errorClass: '@'
      customClass: '@'
      roundTime: '@'
      smartDays: '@'
    link: (scope, element, attrs, ctrl) ->
      combodateInput = $(element)
      combodateInput.combodate
        format: scope.format || defaultDateFormat
        template: scope.template
        minYear: scope.minYear
        maxYear: scope.maxYear
        yearDescending: scope.yearDescending
        minuteStep: scope.minuteStep
        secondStep: scope.secondStep
        firstItem: scope.firstItem
        errorClass: scope.errorClass
        customClass: scope.customClass
        roundTime: scope.roundTime
        smartDays: true

      scope.$watch 'value', ->
        if scope.value
          combodateInput.combodate('setValue', scope.value)
      scope.$watch 'myDisabled', ->
        if scope.myDisabled?
          combodateInput.combodate('setDisabled', scope.myDisabled)

      combodateInput.parent().find('select').change ->
        ctrl.$setViewValue(combodateInput.combodate('getValue'))



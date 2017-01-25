ko = require 'knockout'

ko.bindingHandlers.toggle =
  update: (element, valueAccessor, allBindings) ->
    value = valueAccessor()
    event = allBindings.get('toggleEvent') || 'click'
    switch event
      when 'hover'
        ko.applyBindingsToNode element, {
          event:
            mouseover: ->
              value !value()
            mouseout: ->
              value !value()
        }
      else
        ko.applyBindingsToNode element, {
          click: ->
            value !value()
        }
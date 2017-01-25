ko = require 'knockout'
require './Common'

animate_show_delay = 5
visible_cls = 'visible'

ko.bindingHandlers.transitionIf = {
  init: (element) ->
    childElements = ko.utils.arrayMap ko.utils.cloneNodes(ko.virtualElements.childNodes(element), true), (e) ->
      if e.nodeType is 1
        ko.utils.toggleDomNodeCssClass e, 'init', true
      e
    ko.virtualElements.emptyNode element
    ko.utils.domData.set element, 'childElements', childElements

    {controlsDescendantBindings: true}

  update: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
    value = ko.unwrap valueAccessor()
    childElements = ko.utils.domData.get element, 'childElements'

    if value is on
      delay = animate_show_delay
      _childElements = ko.utils.cloneNodes(childElements)
      ko.virtualElements.setDomNodeChildren element, _childElements
      ko.utils.arrayForEach _childElements, (e) ->
        if e.nodeType isnt 1
          return

        listener = ->
          if not ko.utils.hasClass @, visible_cls
            ko.removeNode @
        e.addEventListener 'webkitTransitionEnd', listener
        e.addEventListener 'transitionend', listener

        setTimeout ->
          ko.utils.toggleDomNodeCssClass e, visible_cls, true
        , delay
        delay += allBindings.get('transitionShowDelay') or 0
      ko.applyBindingsToDescendants bindingContext, element
    else
      if ko.virtualElements.childNodes(element).length is 0
        return
      delay = 0
      ko.utils.arrayForEach ko.virtualElements.childNodes(element), (e) ->
        if e.nodeType isnt 1
          return
        setTimeout ->
          ko.utils.toggleDomNodeCssClass e, visible_cls, false
        , delay
        delay += allBindings.get('transitionHideDelay') or 0
}

ko.bindingHandlers.transitionIfnot = {
  init: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
    ko.bindingHandlers.transitionIf.init element, valueAccessor, allBindings, viewModel, bindingContext
  update: (element, valueAccessor, allBindings, viewModel, bindingContext) ->
    ko.bindingHandlers.transitionIf.update element, ->
      !ko.unwrap valueAccessor()
    , allBindings, viewModel, bindingContext
}

ko.virtualElements.allowedBindings.transitionIf = true
ko.virtualElements.allowedBindings.transitionIfnot = true
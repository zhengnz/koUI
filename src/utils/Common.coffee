ko = require 'knockout'

ko.utils.hasClass = (element, cls) ->
  obj_class = element.className
  check = ko.utils.arrayFilter obj_class.split(/\s+/), (c) ->
    c is cls
  check.length > 0

ko.bindingHandlers.debug = {
  update: (element, valueAccessor) ->
    console.log ko.unwrap valueAccessor()
}
ko.virtualElements.allowedBindings.debug = true
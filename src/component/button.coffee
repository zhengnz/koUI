ko = require 'knockout'
btnTemplate = require '../tpl/button.html'
btnGroupTemplate = require '../tpl/buttonGroup.html'

class buttonViewModel
  constructor: (params, componentInfo) ->
    @data = ko.dataFor componentInfo.element
    @click = if params.click then params.click.bind(@data) else ->
    @active = ko.observable false
    @hover = ko.observable false
    @disposes = []

    @disable = ko.pureComputed =>
      ko.unwrap params.disable or false

    @loading = ko.pureComputed =>
      ko.unwrap params.loading or false

    @href = ko.pureComputed =>
      ko.unwrap params.href or 'javascript:;'

    @cls = ko.pureComputed =>
      type = ko.unwrap params.type or null
      cls = 'ko-button'
      if type
        cls = "#{cls} ko-#{type}"

      if componentInfo.templateNodes.length is 0
        cls = "#{cls} ko-icon-only"

      if @active()
        cls = "#{cls} ko-active"

      if @hover()
        cls = "#{cls} ko-hover"

      shape = ko.unwrap params.shape or null
      if shape
        cls = "#{cls} ko-#{shape}"

      fluid = ko.unwrap params.fluid or null
      if fluid
        cls = "#{cls} ko-fluid"

      size = ko.unwrap params.size or null
      if size
        cls = "#{cls} ko-#{size}"

      if @disable() is on
        cls = "#{cls} ko-disable"

      cls

    @icon = ko.pureComputed =>
      icon = ko.unwrap params.icon or null
      if icon then "iconfont icon-#{icon}" else null

    @icon_text = ko.pureComputed =>
      ko.unwrap params.iconText or null

    @disposes = @disposes.concat [@cls]

  mouseDown: ->
    @active on

  mouseUp: ->
    @active off

  mouseOver: ->
    @hover on

  mouseOut: ->
    @hover off

  dispose: ->
    ko.utils.arrayForEach @disposes, (obj) ->
      obj.dispose()
    
ko.components.register 'ko-button', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new buttonViewModel params, componentInfo
  template: btnTemplate
}

class buttonGroupViewModel
  constructor: (params, @componentInfo) ->
    @data = ko.dataFor @componentInfo.element

    @cls = ko.pureComputed ->
      cls = 'ko-button-group'
      shape = ko.unwrap params.shape or null
      if shape
        cls = "#{cls} ko-#{shape}"

      size = ko.unwrap params.size or null
      if size
        cls = "#{cls} ko-#{size}"

      vertical = ko.unwrap params.vertical or false
      if vertical
        cls = "#{cls} ko-vertical"

      cls

ko.components.register 'ko-button-group', {
  viewModel:
    createViewModel: (params, componentInfo) ->
      new buttonGroupViewModel params, componentInfo
  template: btnGroupTemplate
}
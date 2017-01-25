ko = require 'knockout'
template = require '../tpl/input.html'

class viewModel
  constructor: (params, componentInfo) ->
    ieVersion = ko.utils.ieVersion ? 10
    can_use_placeholder = ieVersion > 9 #判断是否支持placeholder

    @disposes = [] #收集所有需要释放的匿名订阅或计算器

    @type = ko.observable ko.unwrap params.type or 'text'

    @size = ko.computed ->
      ko.unwrap params.size or null

    @width = ko.computed ->
      w = ko.unwrap params.width or '100%'
      componentInfo.element.firstChild.style['width'] = w

    @placeholder = ko.computed ->
      ko.unwrap params.placeholder or null

    @focus = ko.observable ko.unwrap params.hasFocus or false
    @disposes.push @focus.subscribe (v) =>
      if ko.isObservable params.hasFocus
        params.hasFocus v

    @hover = ko.observable false

    @visible = ko.pureComputed =>
      ko.unwrap params.visible ? true
    @disable = ko.pureComputed =>
      ko.unwrap params.disable or false

    @origin_type = @type() #记录初始类型
    params.value = params.value ? ko.observable(null)
    @value = ko.computed {
      read: ->
        value = ko.unwrap params.value or null
        #placeholder兼容处理
        if not can_use_placeholder and not value and not @focus()
          if @type() is 'password'
            @type 'text'
          return @placeholder()
        if @type() isnt @origin_type
          @type @origin_type
        value
      write: (value) ->
        if ko.isObservable params.value
          params.value value
      owner: @
    }

    #icon
    @right_icon = ko.pureComputed =>
      icon = ko.unwrap params.rightIcon or null
      if not icon?
        return null
      "iconfont icon-#{icon} right"
    @right_icon_text = ko.pureComputed =>
      ko.unwrap params.rightIconText or null

    @left_icon = ko.pureComputed =>
      icon = ko.unwrap params.leftIcon or null
      if not icon?
        return null
      "iconfont icon-#{icon} left"
    @left_icon_text = ko.pureComputed =>
      ko.unwrap params.leftIconText or null
    @disposes = @disposes.concat [
      @size, @width, @placeholder, @visible, @disable, @value
      @right_icon, @right_icon_text, @left_icon, @left_icon_text
    ]

  dispose: ->
    ko.utils.arrayForEach @disposes, (obj) ->
      obj.dispose()

ko.components.register 'ko-input', {
  viewModel:
    createViewModel: (params, componentInf) ->
      new viewModel params, componentInf
  template: template
}
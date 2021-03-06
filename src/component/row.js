// Generated by CoffeeScript 1.10.0
(function() {
  var ko, template, viewModel;

  ko = require('knockout');

  template = require('../tpl/row.html');

  viewModel = (function() {
    function viewModel(params, componentInfo) {
      var e;
      this.data = {
        $context: params.data,
        gutter: params.gutter || null
      };
      e = componentInfo.element.firstChild;
      this.disposes = [];
      this.disposes.push(ko.computed((function(_this) {
        return function() {
          var gutter, px;
          gutter = ko.unwrap(_this.data.gutter);
          if (gutter != null) {
            px = "-" + (Math.floor(gutter / 2)) + "px";
            e.style['margin-left'] = px;
            return e.style['margin-right'] = px;
          } else {
            e.style['margin-left'] = 'auto';
            return e.style['margin-right'] = 'auto';
          }
        };
      })(this)));
      this.visible = ko.pureComputed((function(_this) {
        return function() {
          var ref;
          return ko.unwrap((ref = params.visible) != null ? ref : true);
        };
      })(this));
      this.disposes.push(this.visible);
    }

    viewModel.prototype.dispose = function() {
      return ko.utils.arrayForEach(this.disposes, function(obj) {
        return obj.dispose();
      });
    };

    return viewModel;

  })();

  ko.components.register('ko-row', {
    viewModel: {
      createViewModel: function(params, componentInfo) {
        params.data = ko.dataFor(componentInfo.element);
        return new viewModel(params, componentInfo);
      }
    },
    template: template
  });

}).call(this);

//# sourceMappingURL=row.js.map

// Generated by CoffeeScript 1.10.0
(function() {
  var viewModel;

  viewModel = (function() {
    function viewModel() {
      this.active = ko.observable(false);
      this.data = ko.observable('Hello World!');
      this.size = ko.observable(8);
      this.gutter = ko.observable(16);
      this.input_value = ko.observable(null);
    }

    viewModel.prototype.test_click = function() {
      return alert(this.data());
    };

    return viewModel;

  })();

  ko.applyBindings(new viewModel());

}).call(this);

//# sourceMappingURL=test.js.map
HTMLWidgets.widget({
  name: 'nomnoml',
  type: 'output',

  factory: function(el, width, height) {
    return {
      renderValue: function(x) {
        el.innerHTML = nomnoml.renderSvg(x.code);
      },

      resize: function(width, height) {
      }
    };
  }
});
HTMLWidgets.widget({
  name: 'nomnoml',
  type: 'output',

  factory: function(el, width, height) {
    var g = null;
    var svg = null;
    var wrapper = null;
    
    var resize = function(width, height) {
      el.style.width = width;
      el.style.height = height;
      
      wrapper.setAttribute('width', width);
      wrapper.setAttribute('height', height);
      
      var scale = Math.min(width / svg.getAttribute("width"), height / svg.getAttribute("height"));
      var innerWidth = svg.getAttribute("width") * scale;
      var innerHeight = svg.getAttribute("height") * scale;
      g.setAttribute(
        "transform",
        "translate(" + (width  / 2 - innerWidth / 2) +
        "," + (height / 2 - innerHeight / 2) + ")" +
        "scale(" + scale + ") "
      );  
    };
    
    return {
      renderValue: function(x) {
        wrapper = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        wrapper.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:xlink", "http://www.w3.org/1999/xlink");
        el.appendChild(wrapper);
        
        g = document.createElementNS("http://www.w3.org/2000/svg", "g");
        g.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:xlink", "http://www.w3.org/1999/xlink");
        wrapper.appendChild(g);
        
        g.innerHTML = nomnoml.renderSvg(x.code);
        
        svg = g.childNodes[0];
        resize(width, height);
      },

      resize: function(width, height) {
        resize(width, height);
      }
    };
  }
});
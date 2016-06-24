function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXml = __helpers.x,
      forEach = __helpers.f;

  return function render(data, out) {
    out.w("Hello " +
      escapeXml(data.name) +
      "! ");

    if (notEmpty(data.items)) {
      out.w("<ul>");

      forEach(data.items, function(item) {
        out.w("<li>" +
          escapeXml(item) +
          "</li>");
      });

      out.w("</ul>");
    }

    out.w("<p>home</p>");
  };
}

(module.exports = require("marko").c(__filename)).c(create);

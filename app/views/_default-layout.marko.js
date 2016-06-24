function create(__helpers) {
  var str = __helpers.s,
      empty = __helpers.e,
      notEmpty = __helpers.ne,
      escapeXml = __helpers.x,
      __loadTag = __helpers.t,
      layout_placeholder = __loadTag(require("marko/taglibs/layout/placeholder-tag"));

  return function render(data, out) {
    out.w("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\"><meta name=\"viewport\" content=\"initial-scale=1.0, user-scalable=no\"><meta name=\"viewport\" content=\"user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi\"><title>");

    layout_placeholder({
        name: "title",
        content: data.layoutContent
      }, out);

    out.w(" - Thomas Torfs</title><script src=\"/js/app.js\"></script><script src=\"/js/templates.js\"></script><link rel=\"stylesheet\" href=\"/css/main.css\"></head></html><body>");

    layout_placeholder({
        name: "body",
        content: data.layoutContent
      }, out);

    out.w("</body>");
  };
}

(module.exports = require("marko").c(__filename)).c(create);

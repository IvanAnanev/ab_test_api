// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

const addOptionAnchor = document.getElementById("add_option");
if (addOptionAnchor) {
  addOptionAnchor.addEventListener("click", (e) => {
    e.preventDefault();

    const template = addOptionAnchor.dataset.template;
    const time =new Date().getTime();
    const uniq_template = template.replace(/\[0\]/g, `[${time}]`).replace(/_0_/g, `_${time}_`);
    let div = document.createElement("div");
    div.innerHTML = uniq_template.trim();

    addOptionAnchor.parentNode.insertBefore(div.childNodes[0], addOptionAnchor);
  })
}

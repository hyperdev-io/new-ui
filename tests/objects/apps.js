const {
  css,
  xpath,
  id,
  cssContainingText
} = require("@testx/objects-standard");

module.exports = {
  AppsNewApp: xpath("//span[.='New App']"),
  AppsDockerCompose: xpath("//label[.='Docker Compose']"),
  AppsBigboatCompose: xpath("//label[.='BigBoat Compose']"),
  AppsEditor: () => ({
    ...id("ace-#{@props.name}"),
    behaviour: {
      set: val => {
        const v = val.replace(/\n/g, "\\n");
        browser.executeScript(
          `ace.edit("ace-#{@props.name}").getSession().getDocument().setValue("${v}", -1);`
        );
      },
      get: () =>
        browser.executeScript(
          'return ace.edit("ace-#{@props.name}").getSession().getDocument().getValue();'
        )
    }
  }),
  AppsSaveButton: cssContainingText("nav span", "Save")
};

const objects = {
  NewApp: () => cy.contains("span", "New App")
};

Cypress.Commands.add("gotoPage", page => {
  cy.contains("a", page).click();
  cy.get("header span").should("contain", page);
});

Cypress.Commands.add("set", elems => {
  for (const [key, val] of Object.entries(elems)) {
    const el = objects[key].call(this);
    if (val === null) {
      el.click();
    } else {
      el.type(val);
    }
  }
});

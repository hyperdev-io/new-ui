describe("BigBoat main menu", () =>
  it("can reach every main page", () => {
    cy.visit("/");
    cy.gotoPage("Apps");
    cy.gotoPage("Instances");
    cy.gotoPage("Storage");
    cy.gotoPage("App Store");
  }));

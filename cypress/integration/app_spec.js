describe("BigBoat Apps page", () =>
  it("should be able to create a new app", () => {
    cy.visit("/");
    cy.gotoPage("Apps");
    cy.set({ NewApp: null });
  }));

describe('example to-do app', () => {
  beforeEach(() => {
    // Cypress starts out with a blank slate for each test
    // so we must tell it to visit our website with the `cy.visit()` command.
    // Since we want to visit the same URL at the start of all our tests,
    // we include it in our beforeEach function so that it runs before each test
    cy.visit('http://localhost:3000/')
  })
  it("Click on a product and navigate to the product detail page", () => {
    cy.get(".products article")
    .first()
    .click()

    cy.get(".product-detail")
    .should("be.visible");
  });

  it("Click on the last product and navigate to the product detail page", () => {
    cy.visit('http://localhost:3000/')
    cy.get(".products article")
    .last()
    .click()

    cy.get(".product-detail")
    .should("be.visible");
  });

})
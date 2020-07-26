Feature: Spire web app - Customers page
  Description: Testing the spire web app Customers page

  Background: Starting on the Customers page
    Given Luke is on the Customers page

  @customer
  Scenario: Admin creates a new Customer
    When He creates a new Customer
    Then The Customer is created and saved successfully

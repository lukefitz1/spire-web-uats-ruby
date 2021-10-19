@customer @smoke
Feature: Spire web app - Customers page
  Description: Testing the spire web app Customers page

  @create
  Scenario: Admin creates a new Customer
    Given Luke is on the Customers page
    When He creates a new Customer
    Then The Customer is created and saved successfully

  @update
  Scenario: Admin updates a Customer
    Given Luke has a customer named Update Customer
    And He is on the Customers page
    When He updates the customer
    Then The customer is updated successfully

  @delete
  Scenario: Admin deletes a Customer
    Given Luke has a customer named Delete Customer
    And He is on the Customers page
    When He deletes the customer
    Then The customer is deleted successfully
Feature: Spire web app - Collections page
  Description: Testing the spire web app Collections page

  Background: Starting on the Collections page
    Given Luke is on the Collections page

  @collection
  Scenario: Admin creates a new Collection
    When He creates a new Collection
    Then The Collection is created and saved successfully
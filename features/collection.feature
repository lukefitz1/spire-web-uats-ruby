@collection @smoke
Feature: Spire web app - Collections page
  Description: Testing the spire web app Collections page

  @create
  Scenario: Admin creates a new Collection
    Given Luke is on the Collections page
    When He creates a new Collection
    Then The Collection is created and saved successfully

  @update
  Scenario: Admin updates a Collection
    Given Luke has a collection named Update Collection
    And He is on the Collections page
    When He updates the collection
    Then The collection is updated successfully

  @delete
  Scenario: Admin deletes a Collection
    Given Luke has a collection named UAT Collection
    And He is on the Collections page
    When He deletes the collection
    Then The collection is deleted successfully
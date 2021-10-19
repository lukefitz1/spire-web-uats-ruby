@artist @smoke
Feature: Spire web app - Artists page
  Description: Testing the spire web app Artists page

  @create
  Scenario: Admin creates a new Artist
    Given Luke is on the Artists page
    When He creates a new Artist
    Then The Artist is created and saved successfully

  @update
  Scenario: Admin updates an Artist
    Given Luke has an artist named Update Artist
    And He is on the Artist page
    When He updates the artist
    Then The artist is updated successfully

  @delete
  Scenario: Admin deletes an Artist
    Given Luke has an artist named Delete Artist
    And He is on the Artist page
    When He deletes the artist
    Then The artist is deleted successfully

@artwork @smoke
Feature: Spire web app - Artwork page
  Description: Testing the spire web app Artwork page

  @create
  Scenario: Admin creates a new piece of Art
    Given Luke is on the Artwork page
    When He creates a new piece of Art
    Then The Artwork is created and saved successfully

  @update
  Scenario: Admin updates a piece of Art
    Given Luke has a artwork named Update Artwork
    And He is on the Artwork page
    When He updates the art
    Then The art is updated successfully

  @delete
  Scenario: Admin deletes a piece of Art
    Given Luke has a artwork named Delete Artwork
    And He is on the Artwork page
    When He deletes the art
    Then The art is deleted successfully
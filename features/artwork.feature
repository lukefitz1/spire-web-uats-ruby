Feature: Spire web app - Artwork page
  Description: Testing the spire web app Artwork page

  Background: Starting on the Artwork page
    Given Luke is on the Artwork page

  @artwork
  Scenario: Admin creates a new piece of Art
    When He creates a new piece of Art
    Then The Artwork is created and saved successfully
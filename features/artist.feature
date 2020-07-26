Feature: Spire web app - Artists page
Description: Testing the spire web app Artists page
	
  Background: Starting on the Artists page
    Given Luke is on the Artists page

  @artist
  Scenario: Admin creates a new Artist
    When He creates a new Artist
    Then The Artist is created and saved successfully

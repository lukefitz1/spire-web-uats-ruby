Feature: Spire web app - General Information page
  Description: Testing the spire web app General Information page

  Background: Starting on the General Information page
    Given Luke is on the General Information page

  @general_information
  Scenario: Admin creates a new piece of General Information
    When He creates a new piece of General Information
    Then The piece of General Information is created and saved successfully

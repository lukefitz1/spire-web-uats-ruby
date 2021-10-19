@general_information @smoke
Feature: Spire web app - General Information page
  Description: Testing the spire web app General Information page

  @create
  Scenario: Admin creates a new piece of General Information
    Given Luke is on the General Information page
    When He creates a new piece of General Information
    Then The piece of General Information is created and saved successfully

  @update
  Scenario: Admin updates a piece of General Information
    Given Luke has a piece of GI named Update GI
    And He is on the General Information page
    When He updates the piece of GI
    Then The GI is updated successfully

  @delete
  Scenario: Admin deletes a piece of General Information
    Given Luke has a piece of GI named UAT GI
    And He is on the General Information page
    When He deletes the piece of GI
    Then The GI is deleted successfully

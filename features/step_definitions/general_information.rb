# frozen_string_literal: true

Given('Luke is on the General Information page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @gi = PageObjects::GeneralInformationPage.new
  @customer = PageObjects::CustomerPage.new

  @login.auth0_login
  @customer.wait_for_customers_heading

  visit "#{@base_url}/general_informations"
end

Given(/^Luke has a piece of GI named (.*?)$/) do |general_info|
  @general_info_name = general_info
  login = Api::Login.new
  login.login

  gi = Api::GeneralInformation.new
  gi.create_general_information(general_info)
end

Given('He is on the General Information page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @gi = PageObjects::GeneralInformationPage.new
  @customer = PageObjects::CustomerPage.new

  @login.auth0_login
  @customer.wait_for_customers_heading

  visit "#{@base_url}/general_informations"
  @gi.wait_for_gi_table
end

When('He creates a new piece of General Information') do
  @gi.click_general_info_create_link

  @gi.create_new_general_info
end

When('He updates the piece of GI') do
  @gi.update_gi(@general_info_name)
end

When('He deletes the piece of GI') do
  @gi.delete_collection(@general_info_name)
end

Then('The piece of General Information is created and saved successfully') do
  @gi.wait_for_gi_create_success_message

  expect(@gi.get_gi_create_success_message_text).to eq('General information was successfully created.')
end

Then('The GI is updated successfully') do
  @gi.wait_for_gi_create_success_message

  expect(@gi.get_gi_create_success_message_text).to eq('General information was successfully updated.')
end

Then('The GI is deleted successfully') do
  @gi.wait_for_gi_create_success_message

  expect(@gi.get_gi_create_success_message_text).to eq('General information was successfully destroyed.')
end
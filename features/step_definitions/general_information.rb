# frozen_string_literal: true

require_relative '../../api/login'

Given('Luke is on the General Information page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @gi = PageObjects::GeneralInformationPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message

  visit "#{@base_url}/general_informations"
end

When('He creates a new piece of General Information') do
  @gi.click_general_info_create_link

  @gi.create_new_general_info
end

Then('The piece of General Information is created and saved successfully') do
  @gi.wait_for_gi_create_success_message

  expect(@gi.get_gi_create_success_message_text).to eq('General information was successfully created.')
end
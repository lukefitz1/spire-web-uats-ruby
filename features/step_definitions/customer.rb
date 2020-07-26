# frozen_string_literal: true

require_relative '../../api/login'

Given('Luke is on the Customers page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message
end

When('He creates a new Customer') do
  @customer.click_customer_create_link

  @customer.create_new_customer
end

Then('The Customer is created and saved successfully') do
  @customer.wait_for_customer_create_success_message

  expect(@customer.get_customer_create_success_message_text).to eq('Customer was successfully created.')
end
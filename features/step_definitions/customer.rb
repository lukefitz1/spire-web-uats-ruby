# frozen_string_literal: true

require_relative '../../api/login'

Given('Luke is on the Customers page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message
end

Given(/^Luke has a customer named (.*?)$/) do |cust|
  @cust = cust

  login = Api::Login.new
  login.login

  customer = Api::Customer.new
  customer.create_customer(cust)
end

Given('He is on the Customers page') do
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

When('He updates the customer') do
  @customer.update_customer(@cust)
end

When('He deletes the customer') do
  @customer.delete_customer(@cust)
end

Then('The Customer is created and saved successfully') do
  @customer.wait_for_customer_create_success_message

  expect(@customer.get_customer_create_success_message_text).to eq('Customer was successfully created.')
end

Then('The customer is updated successfully') do
  @customer.wait_for_customer_create_success_message

  expect(@customer.get_customer_create_success_message_text).to eq('Customer was successfully updated.')
end

Then('The customer is deleted successfully') do
  @customer.wait_for_customer_create_success_message

  expect(@customer.get_customer_create_success_message_text).to eq('Customer was successfully destroyed.')
end
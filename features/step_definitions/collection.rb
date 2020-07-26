# frozen_string_literal: true

require_relative '../../api/login'

Given('Luke is on the Collections page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @collection = PageObjects::CollectionPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message

  visit "#{@base_url}/collections"
end

When('He creates a new Collection') do
  @collection.click_collection_create_link

  @collection.create_new_collection
end

Then('The Collection is created and saved successfully') do
  @collection.wait_for_collection_create_success_message

  expect(@collection.get_collection_create_success_message_text).to eq('Collection was successfully created.')
end
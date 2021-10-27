# frozen_string_literal: true

Given('Luke is on the Collections page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @collection = PageObjects::CollectionPage.new
  @customer = PageObjects::CustomerPage.new

  @login.auth0_login
  @customer.wait_for_customers_heading

  visit "#{@base_url}/collections"
end

Given(/^Luke has a collection named (.*?)$/) do |coll|
  @coll = coll
  login = Api::Login.new
  login.login

  collection = Api::Collection.new
  collection.create_collection(coll)
end

Given('He is on the Collections page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @collection = PageObjects::CollectionPage.new
  @customer = PageObjects::CustomerPage.new

  @login.auth0_login
  @customer.wait_for_customers_heading

  visit "#{@base_url}/collections"
  @collection.wait_for_collection_table
end

When('He creates a new Collection') do
  @collection.click_collection_create_link

  @collection.create_new_collection
end

When('He updates the collection') do
  @collection.update_collection(@coll)
end

When('He deletes the collection') do
  @collection.delete_collection(@coll)
end

Then('The Collection is created and saved successfully') do
  @collection.wait_for_collection_create_success_message

  expect(@collection.get_collection_create_success_message_text).to eq('Collection was successfully created.')
end

Then('The collection is updated successfully') do
  @collection.wait_for_collection_create_success_message

  expect(@collection.get_collection_create_success_message_text).to eq('Collection was successfully updated.')
end

Then('The collection is deleted successfully') do
  @collection.wait_for_collection_create_success_message

  expect(@collection.get_collection_create_success_message_text).to eq('Collection was successfully destroyed.')
end

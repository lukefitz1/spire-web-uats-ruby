# frozen_string_literal: true

require_relative '../../api/login'

Given('Luke is on the Artwork page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @art = PageObjects::ArtworkPage.new
  @customer = PageObjects::CustomerPage.new

  @login.auth0_login
  @customer.wait_for_customers_heading

  visit "#{@base_url}/artworks"
end

Given(/^Luke has a artwork named (.*?)$/) do |art|
  @artwork_title = art
  login = Api::Login.new
  login.login

  artwork = Api::Artwork.new
  artwork.create_artwork(art)
end

Given('He is on the Artwork page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @art = PageObjects::ArtworkPage.new
  @customer = PageObjects::CustomerPage.new

  @login.auth0_login
  @customer.wait_for_customers_heading

  visit "#{@base_url}/artworks"
  @art.wait_for_art_table
end

When('He creates a new piece of Art') do
  @art.click_artwork_create_link

  @art.create_new_artwork
end

When('He updates the art') do
  @art.update_art(@artwork_title)
end

When('He deletes the art') do
  @art.delete_art(@artwork_title)
end

Then('The Artwork is created and saved successfully') do
  @art.wait_for_artwork_create_success_message

  expect(@art.get_artwork_create_success_message_text).to eq('Artwork was successfully created.')
end

Then('The art is updated successfully') do
  @art.wait_for_artwork_create_success_message

  expect(@art.get_artwork_create_success_message_text).to eq('Artwork was successfully updated.')
end

Then('The art is deleted successfully') do
  @art.wait_for_artwork_create_success_message

  expect(@art.get_artwork_create_success_message_text).to eq('Artwork was successfully destroyed.')
end
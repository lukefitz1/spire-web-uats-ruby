# frozen_string_literal: true

require_relative '../../api/login'

Given('Luke is on the Artwork page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @art = PageObjects::ArtworkPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message

  visit "#{@base_url}/artworks"
end

When('He creates a new piece of Art') do
  @art.click_artwork_create_link

  @art.create_new_artwork
end

Then('The Artwork is created and saved successfully') do
  @art.wait_for_artwork_create_success_message

  expect(@art.get_artwork_create_success_message_text).to eq('Artwork was successfully created.')
end
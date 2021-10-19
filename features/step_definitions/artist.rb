# frozen_string_literal: true

Given('Luke is on the Artists page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @artist = PageObjects::ArtistPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message

  visit "#{@base_url}/artists"
end

Given(/^Luke has an artist named (.*?)$/) do |artist_name|
  @artist_name = artist_name

  login = Api::Login.new
  login.login

  artist = Api::Artist.new
  artist.create_artist(artist_name)
end

Given('He is on the Artist page') do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @artist = PageObjects::ArtistPage.new
  @customer = PageObjects::CustomerPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message

  visit "#{@base_url}/artists"
  @artist.wait_for_artist_table
end

When('He creates a new Artist') do
  @artist.click_artist_create_link

  @artist.create_new_artist
end

When('He updates the artist') do
  @artist.update_artist(@artist_name)
end

When('He deletes the artist') do
  @artist.delete_artist(@artist_name)
end

Then('The Artist is created and saved successfully') do
  @artist.wait_for_artist_create_success_message

  expect(@artist.get_artist_create_success_message_text).to eq('Artist was successfully created.')
end

Then('The artist is updated successfully') do
  @artist.wait_for_artist_create_success_message

  expect(@artist.get_artist_create_success_message_text).to eq('Artist was successfully updated.')
end

Then('The artist is deleted successfully') do
  @artist.wait_for_artist_create_success_message

  expect(@artist.get_artist_create_success_message_text).to eq('Artist was successfully destroyed.')
end
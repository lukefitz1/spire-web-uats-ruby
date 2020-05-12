require_relative '../../api/login'

Given("Luke is on the Artists page") do
  visit @base_url
  @login = PageObjects::LoginPage.new
  @artist = PageObjects::ArtistsPage.new
  @customer = PageObjects::CustomersPage.new

  @login.login
  @customer.wait_for_successful_sign_in_message

  visit "#{@base_url}/artists/new"
end

When("He creates a new Artist") do
  @artist.create_new_artist
end

Then("The Artist is created and saved successfully") do
  @artist.wait_for_artist_create_success_message
  
  expect(@artist.get_artist_create_success_message_text).to eq('Artist was successfully created.')
end
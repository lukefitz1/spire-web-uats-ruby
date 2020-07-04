Given('Luke is trying to use the API') do
  login = Api::Login.new

  resp = login.login
  json_resp = JSON.parse(resp)
  Kernel.puts json_resp['data']['auth_token']
end

When('He calls the API') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the API returns a response') do
  pending # Write code here that turns the phrase above into concrete actions
end
Given('Luke is trying to use the API') do
  login = Api::Login.new

  resp = login.login
  # Kernel.puts resp.headers
  # resp_headers = JSON.parse(resp.headers)

  Kernel.puts resp.headers[:access_token]
  Kernel.puts resp.headers[:client]
  Kernel.puts resp.headers[:token_type]
  Kernel.puts resp.headers[:expiry]
  Kernel.puts resp.headers[:uid]

  json_resp = JSON.parse(resp)
  # Kernel.puts json_resp['data']['auth_token']
end

When('He calls the API') do
  pending # Write code here that turns the phrase above into concrete actions
end

Then('the API returns a response') do
  pending # Write code here that turns the phrase above into concrete actions
end
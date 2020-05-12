require 'rest-client'

module Api
	class Login
		include Capybara::DSL

		def initialize
      auth_token = ''
      headers = ''
    end
    
    def login 
      url = 'http://localhost:3000/api/sign-in'
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
      }

      payload = {
        'user_login[email]': 'lukefitz1@gmail.com',
        'user_login[password]': 'pass4luke'
      }
      
      RestClient.post(url, payload, headers)
    end

	end
end

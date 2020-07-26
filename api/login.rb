# frozen_string_literal: true

require 'rest-client'

module Api
  class Login
    include Capybara::DSL

    def initialize
      auth_token = ''
      headers = ''
    end

    def login
      url = "#{ENV['BASE_URL']}/api/auth/sign_in"
      headers = {
        'Content-Type': 'application/json'
      }

      payload = {
        'email': ENV['USER_EMAIL'],
        'password': ENV['USER_PASSWORD']
      }

      RestClient.post(url, payload, headers)
    end

  end
end

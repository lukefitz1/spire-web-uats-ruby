# frozen_string_literal: true

require 'rest-client'
require 'json'

module Api
  class Login
    include Capybara::DSL

    @@bearer_token = ''

    def initialize
      @headers = ''
    end

    def login
      url = "#{ENV['AUTH0_URL']}"
      headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
      }

      payload = {
        'username': ENV['USER_EMAIL'],
        'password': ENV['USER_PASSWORD'],
        'grant_type': ENV['AUTH0_GRANT_TYPE'],
        'realm': ENV['AUTH0_REALM'],
        'audience': ENV['AUTH0_AUDIENCE'],
        'client_id': ENV['AUTH0_CLIENT_ID'],
        'client_secret': ENV['AUTH0_CLIENT_SECRET']
      }

      resp = RestClient.post(url, payload, headers)

      @response_json = JSON.parse(resp.body)
      @@bearer_token = @response_json['access_token']

      resp
    end

  end
end

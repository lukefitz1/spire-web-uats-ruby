# frozen_string_literal: true

require 'rest-client'

module Api
  class Login
    include Capybara::DSL

    @@access_token = ''
    @@client = ''
    @@token_type = ''
    @@expiry = ''
    @@uid = ''

    def initialize
      # @access_token = ''
      # @client = ''
      # @token_type = ''
      # @expiry = ''
      # @uid = ''
      @headers = ''
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

      resp = RestClient.post(url, payload, headers)

      @@access_token = resp.headers[:access_token]
      @@client = resp.headers[:client]
      @@token_type = resp.headers[:token_type]
      @@expiry = resp.headers[:expiry]
      @@uid = resp.headers[:uid]

      resp
    end

  end
end

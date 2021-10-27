# frozen_string_literal: true

require 'rest-client'

module Api
  class Customer < Login
    include Capybara::DSL

    def create_customer(cust)
      url = "#{ENV['BASE_URL']}/api/customer"
      headers = {
        content_type: 'application/json',
        authorization: "Bearer #{@@bearer_token}"
      }

      name = cust.split
      payload = {
        firstName: name[0],
        lastName: name[1],
        email_address: '',
        phone_number: '1112223333',
        street_address: '1234 Main St',
        city: 'Topeka',
        state: 'KS',
        zip: '12345',
        referred_by: 'UAT test',
        project_notes: 'These are some notes on the project'
      }

      resp = RestClient.post(url, payload.to_json, headers)
      json_resp = JSON.parse(resp)
      json_resp['id']
    end

  end
end
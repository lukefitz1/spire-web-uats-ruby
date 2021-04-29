# frozen_string_literal: true

require 'rest-client'

module Api
  class Collection < Login
    include Capybara::DSL

    def create_collection(coll)
      url = "#{ENV['BASE_URL']}/api/collections"
      headers = {
        content_type: 'application/json',
        'access-token': @@access_token,
        client: @@client,
        uid: @@uid,
        expiry: @@expiry,
        'token-type': @@token_type
      }

      payload = {
        collectionName: coll,
        identifier: 'API',
        year: '2020'
      }

      resp = RestClient.post(url, payload.to_json, headers)
      json_resp = JSON.parse(resp)
      json_resp['id']
    end

  end
end
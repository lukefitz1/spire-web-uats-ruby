# frozen_string_literal: true

require 'rest-client'

module Api
  class Collection < Login
    include Capybara::DSL

    def create_collection(coll)
      url = "#{ENV['BASE_URL']}/api/collections"
      headers = {
        content_type: 'application/json',
        authorization: "Bearer #{@@bearer_token}"
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
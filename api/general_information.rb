# frozen_string_literal: true

require 'rest-client'

module Api
  class GeneralInformation < Login
    include Capybara::DSL

    def create_general_information(gi)
      url = "#{ENV['BASE_URL']}/api/general_informations"
      headers = {
        content_type: 'application/json',
        authorization: "Bearer #{@@bearer_token}"
      }

      payload = {
        information_label: gi,
        information: 'This is some general information generated during an automated test'
      }

      resp = RestClient.post(url, payload.to_json, headers)
      json_resp = JSON.parse(resp)
      json_resp['id']
    end

  end
end
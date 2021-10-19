# frozen_string_literal: true

require 'rest-client'

module Api
  class Artwork < Login
    include Capybara::DSL

    def create_artwork(art)
      url = "#{ENV['BASE_URL']}/api/artwork"
      headers = {
        content_type: 'application/json',
          'access-token': @@access_token,
          client: @@client,
          uid: @@uid,
          expiry: @@expiry,
          'token-type': @@token_type
      }

      payload = {
        ojbId: generate_obj_id,
        artType: 'API Test',
        title: art,
        date: '2019',
        medium: 'Internet',
        description: 'This is a test POST call from an automated test',
        dimensions: '525GB',
        frame_dimensions: '525GB',
        condition: 'Perfect',
        currentLocation: 'Kitchen',
        reviewedBy: 'Michele',
        reviewedDate: '2019'
      }

      resp = RestClient.post(url, payload.to_json, headers)
      json_resp = JSON.parse(resp)
      json_resp['id']
    end

    def generate_obj_id
      num = rand(1000..99999)
      key = rand(36**5).to_s(36)
      "#{num}.#{key}"
    end

  end
end
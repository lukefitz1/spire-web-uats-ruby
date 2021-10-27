# frozen_string_literal: true

require 'rest-client'

module Api
  class Artist < Login
    include Capybara::DSL

    def create_artist(artist_name)
      url = "#{ENV['BASE_URL']}/api/artist"
      headers = {
        content_type: 'application/json',
        authorization: "Bearer #{@@bearer_token}"
      }

      puts "Artist name: #{artist_name}"
      name = artist_name.split
      payload = {
        firstName: name[0],
        lastName: name[1],
        biography: 'This is a bio for an artist',
        additionalInfo: 'USA'
      }

      resp = RestClient.post(url, payload.to_json, headers)
      json_resp = JSON.parse(resp)
      json_resp['id']
    end

  end
end
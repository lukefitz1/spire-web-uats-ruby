# frozen_string_literal: true

require_relative './base_page_object'

module PageObjects
  class ArtistPage < BasePageObject
    include Capybara::DSL

    def initialize
      @artist_create_link = 'body > a'
      @artist_create_form = 'body > form'
      @first_name_input = '#artist_firstName'
      @last_name_input = '#artist_lastName'
      @additional_info_input = '#artist_additionalInfo'
      @bio_input = '#artist_biography'
      @create_artist_btn = 'body > form > div.actions > input[type=submit]'
      @artist_create_success_message = '#notice'
    end

    def wait_for_artist_create_form
      wait_for(@artist_create_form)
    end

    def wait_for_artist_create_success_message
      wait_for(@artist_create_success_message)
    end

    def get_artist_create_success_message_text
      text(@artist_create_success_message)
    end

    def click_artist_create_link
      click(@artist_create_link)
    end

    def create_new_artist
      wait_for_artist_create_form

      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name

      puts "New artist: #{first_name} #{last_name}"

      set(@first_name_input, first_name)
      set(@last_name_input, last_name)
      set(@additional_info_input, 'USA, b 1988')
      set(@bio_input, 'This is some text for the bio for the newly created artist')

      click(@create_artist_btn)
    end
 	end
end

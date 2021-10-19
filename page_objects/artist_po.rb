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
      @artist_table = 'body > form:nth-child(11) > table'
      @artist_search_input = '#search'
      @artist_search_btn = 'body > form:nth-child(8) > input[type=submit]:nth-child(3)'
    end

    def wait_for_artist_table
      wait_for(@artist_table)
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

    def get_table_rows_count
      rows = page.all(@artist_table)
      rows.count
    end

    def perform_artist_search(artist)
      set(@artist_search_input, artist)
      click(@artist_search_btn)
    end

    def search_artists(artist_name)
      perform_artist_search(artist_name)

      row_count = get_table_rows_count
      index = 1
      name = artist_name.split

      while index <= row_count do
        artist_first_name = page.find("body > table > tbody > tr:nth-child(#{index}) > td:nth-child(2)")

        if artist_first_name.text == name[0]
          break
        end

        index += 1
      end

      index
    end

    def create_new_artist
      wait_for_artist_create_form

      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name

      set(@first_name_input, first_name)
      set(@last_name_input, last_name)
      set(@additional_info_input, 'USA, b 1988')
      set(@bio_input, 'This is some text for the bio for the newly created artist')

      click(@create_artist_btn)
    end

    def update_artist(artist)
      index = search_artists(artist)

      click("body > table > tbody > tr:nth-child(#{index}) > td:nth-child(7)")
      wait_for_artist_create_form

      set(@additional_info_input, 'USA, b 2021')
      click(@create_artist_btn)
    end

    def delete_artist(artist)
      index = search_artists(artist)

      click("body > table > tbody > tr:nth-child(#{index}) > td:nth-child(8) > a")
      page.driver.browser.switch_to.alert.accept
    end
 	end
end

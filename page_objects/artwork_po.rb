# frozen_string_literal: true

require_relative './base_page_object'

module PageObjects
  class ArtworkPage < BasePageObject
    include Capybara::DSL

    def initialize
      @artwork_create_link = 'body > a'
      @artwork_create_form = 'body > form'
      @object_id_input = '#artwork_ojbId'
      @art_type_input = '#artwork_artType'
      @title_input = '#artwork_title'
      @date_input = '#artwork_date'
      @medium_input = '#artwork_medium'
      @description_input = '#artwork_description'
      @dimensions_input = '#artwork_dimensions'
      @frame_dimensions_input = '#artwork_frame_dimensions'
      @condition_input = '#artwork_condition'
      @current_location_input = '#artwork_currentLocation'
      @source_input = '#artwork_source'
      @date_acquired_label_input = '#artwork_dateAcquiredLabel'
      @date_acquired_input = '#artwork_dateAcquired'
      @amount_paid_input = '#artwork_amountPaid'
      @current_value_input = '#artwork_currentValue'
      @notes_input = '#artwork_notes'
      @additional_info_label_input = '#artwork_additionalInfoLabel'
      @additional_info_text_input = '#artwork_additionalInfoText'
      @reviewed_by_input = '#artwork_reviewedBy'
      @reviewed_date_input = '#artwork_reviewedDate'
      @provenance_input = '#artwork_provenance'
      @custom_title_input = '#custom_title'
      @custom_artist_label_input = '#custom_artist_label'
      @custom_details_input = '#custom_details'
      @create_artwork_btn = '#new-artwork-form > div.artwork-info-edit-left > div.actions > input[type=submit]'
      @artwork_create_success_message = '#notice'
      @artwork_table = 'body > form:nth-child(11) > table'
      @artwork_table_row = 'body > form:nth-child(11) > table > tbody > tr'
      @artwork_search_input = '#search'
      @artwork_search_btn = 'body > form:nth-child(8) > input[type=submit]:nth-child(3)'
    end

    def wait_for_art_table
      wait_for(@artwork_table)
    end

    def wait_for_artwork_create_form
      wait_for(@artwork_create_form)
    end

    def wait_for_artwork_create_success_message
      wait_for(@artwork_create_success_message)
    end

    def get_artwork_create_success_message_text
      text(@artwork_create_success_message)
    end

    def click_artwork_create_link
      click(@artwork_create_link)
    end

    def perform_artwork_search(artwork)
      set(@artwork_search_input, artwork)
      click(@artwork_search_btn)
    end

    def get_table_rows_count
      rows = page.all(@artwork_table_row)
      rows.count
    end

    def search_artwork(art_title)
      # perform_artwork_search(art_title)

      row_count = get_table_rows_count
      index = 1

      while index <= row_count do
        title = page.find("body > form:nth-child(11) > table > tbody > tr:nth-child(#{index}) > td:nth-child(4)")

        if title.text == art_title
          break
        end

        index += 1
      end

      index
    end

    def create_new_artwork
      wait_for_artwork_create_form

      title = Faker::Movie.title
      random_alpha = Faker::Alphanumeric.alphanumeric(number: 5)
      random_number = rand(1000..9999)

      set(@object_id_input, "#{random_alpha}.#{random_number}")
      set(@art_type_input, 'Painting')
      set(@title_input, title)
      set(@date_input, '2018')
      set(@medium_input, 'Oil on Canvas')
      set(@description_input, '')
      set(@dimensions_input, '25x30')
      set(@frame_dimensions_input, '26x31')
      set(@condition_input, 'Perfect')
      set(@current_location_input, 'Kitchen')
      set(@source_input, 'Tim Hussey')
      set(@date_acquired_label_input, 'Date Acquired')
      set(@date_acquired_input, '2018')
      set(@amount_paid_input, '2000')
      set(@current_value_input, '2500')
      set(@notes_input, '')
      set(@additional_info_label_input, 'Gold Wood Frame')
      set(@additional_info_text_input, '')
      set(@reviewed_by_input, 'L. Williams')
      set(@reviewed_date_input, '2020')
      set(@provenance_input, 'Kitchen')

      click(@create_artwork_btn)
    end

    def update_art(art_title)
      index = search_artwork(art_title)

      click("body > form:nth-child(11) > table > tbody > tr:nth-child(#{index}) > td:nth-child(8) > a")
      wait_for_artwork_create_form

      set(@art_type_input, 'Digital Image')
      click(@create_artwork_btn)
    end

    def delete_art(art_title)
      index = search_artwork(art_title)

      click("body > form:nth-child(11) > table > tbody > tr:nth-child(#{index}) > td:nth-child(9) > a")
      page.driver.browser.switch_to.alert.accept
    end
  end
end
# frozen_string_literal: true

require_relative './base_page_object'

module PageObjects
  class CollectionPage < BasePageObject
    include Capybara::DSL

    def initialize
      @collection_create_link = 'body > a'
      @collection_create_form = 'body > form'
      @collection_name_input = '#collection_collectionName'
      @year_input = '#collection_year'
      @identifier_input = '#collection_identifier'
      @create_collection_btn = 'body > form > div.actions > input[type=submit]'
      @collection_create_success_message = '#notice'
    end

    def wait_for_collection_create_form
      wait_for(@collection_create_form)
    end

    def wait_for_collection_create_success_message
      wait_for(@collection_create_success_message)
    end

    def get_collection_create_success_message_text
      text(@collection_create_success_message)
    end

    def click_collection_create_link
      click(@collection_create_link)
    end

    def create_new_collection
      wait_for_collection_create_form

      collection_name = Faker::Games::Pokemon.name

      set(@collection_name_input, collection_name)
      set(@year_input, '2020')
      set(@identifier_input, 'TEST')

      click(@create_collection_btn)
    end
  end
end
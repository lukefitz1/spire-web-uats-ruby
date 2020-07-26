require_relative './base_page_object'

module PageObjects
  class GeneralInformationPage < BasePageObject
    include Capybara::DSL

    def initialize
      @general_info_create_url = '/general_informations/new'
      @general_info_create_form = 'body > form'
      @general_info_create_link = 'body > a'
      @info_label_input = '#general_information_information_label'
      @info_input = '#general_information_information'
      @create_general_info_btn = 'body > form > div.actions > input[type=submit]'
      @gi_create_success_message = '#notice'
    end

    def click_general_info_create_link
      click(@general_info_create_link)
    end

    def wait_for_general_info_create_form
      wait_for(@general_info_create_form)
    end

    def wait_for_gi_create_success_message
      wait_for(@gi_create_success_message)
    end

    def get_gi_create_success_message_text
      text(@gi_create_success_message)
    end

    def create_new_general_info
      wait_for_general_info_create_form

      random_name = Faker::Games::Pokemon.name
      info_label = "#{random_name} label"
      info = "Here is some general information about #{random_name}"

      set(@info_label_input, info_label)
      set(@info_input, info)
      click(@create_general_info_btn)
    end
  end
end
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
      @gi_table = 'body > table'
      @gi_table_row = 'body > table > tbody > tr'
    end

    def wait_for_gi_table
      wait_for(@gi_table)
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

    def get_table_rows_count
      rows = page.all(@gi_table_row)
      rows.count
    end

    def search_general_infos(gi_name)
      row_count = get_table_rows_count
      index = 1

      while index <= row_count do
        general_info_name = page.find("body > table > tbody > tr:nth-child(#{index}) > td:nth-child(1)")

        if general_info_name.text == gi_name
          break
        end

        index += 1
      end

      index
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

    def update_gi(gi)
      index = search_general_infos(gi)

      click("body > table > tbody > tr:nth-child(#{index}) > td:nth-child(4) > a")
      wait_for_general_info_create_form

      set(@info_label_input, 'Info Label Updated')
      click(@create_general_info_btn)
    end

    def delete_collection(gi)
      index = search_general_infos(gi)

      click("body > table > tbody > tr:nth-child(#{index}) > td:nth-child(5) > a")
      page.driver.browser.switch_to.alert.accept
    end
  end
end
# frozen_string_literal: true

require_relative './base_page_object'

module PageObjects
  class CustomerPage < BasePageObject
    include Capybara::DSL

    def initialize
			@successful_sign_in_message = '#notice'
			@customer_create_link = 'body > a'
			@customer_create_form = 'body > form'
			@first_name_input = '#customer_firstName'
			@last_name_input = '#customer_lastName'
			@email_input = '#customer_email_address'
			@phone_input = '#customer_phone_number'
			@street_address_input = '#customer_street_address'
			@city_input = '#customer_city'
			@state_dropdown = 'body > form > div:nth-child(9) > select'
			@zip_code_input = '#customer_zip'
			@referred_by_input = '#customer_referred_by'
			@project_notes_input = '#project_notes'
			@create_customer_btn = 'body > form > div.actions > input[type=submit]'
			@customer_create_success_message = '#notice'
			@customer_table_row = '#customer-table > tbody > tr'
			@create_customer_btn = 'body > form > div.actions > input[type=submit]'
			@customers_heading = 'body > h1'
    end

		def wait_for_customers_heading
			wait_for(@customers_heading)
		end

    def wait_for_successful_sign_in_message
      wait_for(@successful_sign_in_message)
    end

    def wait_for_customer_create_form
      wait_for(@customer_create_form)
    end

    def wait_for_customer_create_success_message
      wait_for(@customer_create_success_message)
    end

    def get_customer_create_success_message_text
      text(@customer_create_success_message)
    end

    def click_customer_create_link
      click(@customer_create_link)
		end

		def get_table_rows_count
			rows = page.all(@customer_table_row)
			rows.count
		end

		def search_customers(cust_name)
			row_count = get_table_rows_count
			index = 1
			name = cust_name.split

			while index <= row_count do
				customer_name = page.find("#customer-table > tbody > tr:nth-child(#{index}) > td:nth-child(1)")

				if customer_name.text == name[0]
					break
				end

				index += 1
			end

			index
		end

    def create_new_customer
			wait_for_customer_create_form

			first_name = Faker::Name.first_name
			last_name = Faker::Name.last_name
			referred_by = Faker::Name.last_name

			set(@first_name_input, first_name)
			set(@last_name_input, last_name)
			set(@email_input, 'testname@testemail.com')
			set(@phone_input, '1234123412')
			set(@street_address_input, '1234 Main St')
			set(@city_input, 'Cityname')
			# set(@state_dropdown, "")
			set(@zip_code_input, '12345')
			set(@referred_by_input, "M. #{referred_by}")
			set(@project_notes_input, 'These are some notes about the project')

			click(@create_customer_btn)
		end

		def update_customer(cust)
			index = search_customers(cust)

			click("#customer-table > tbody > tr:nth-child(#{index}) > td:nth-child(4) > a")
			wait_for_customer_create_form

			set(@street_address_input, '4321 Main St')
			click(@create_customer_btn)
		end

		def delete_customer(cust)
			index = search_customers(cust)

			click("#customer-table > tbody > tr:nth-child(#{index}) > td:nth-child(5) > a")
			page.driver.browser.switch_to.alert.accept
		end
  end
end

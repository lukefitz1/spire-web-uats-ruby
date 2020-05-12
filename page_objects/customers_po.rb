require_relative './base_page_object'

module PageObjects
	class CustomersPage < BasePageObject
		include Capybara::DSL

		def initialize
      @successful_sign_in_message = '#notice'
		end

    def wait_for_successful_sign_in_message
      wait_for(@successful_sign_in_message)
    end
	end
end

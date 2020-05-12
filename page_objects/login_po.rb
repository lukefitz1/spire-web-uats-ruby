require_relative './base_page_object'

module PageObjects
	class LoginPage < BasePageObject
		include Capybara::DSL

		def initialize
      @login_url = '/users/sign_in'
      @login_form = '#new_user'
      @email_input = '#user_email'
      @password_input = '#user_password'
      @login_btn = '#new_user > div.actions > input'
		end

    def get_login_url
      return @login_url
    end

    def wait_for_login_form
      wait_for(@login_form)
    end

    def login
      wait_for_login_form

      set(@email_input, 'lukefitz1@gmail.com')
      set(@password_input, 'pass4luke')
      click(@login_btn)
    end
	end
end

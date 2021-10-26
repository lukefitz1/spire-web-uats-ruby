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
      @auth0_login_form = 'main.login'
      @auth0_un_input = '#username'
      @auth0_pw_input = '#password'
      @auth0_continue = 'button[type="submit"]'
    end

    def auth0_login
      wait_for_auth0_login_form

      set(@auth0_un_input, ENV['USER_EMAIL'])
      set(@auth0_pw_input, ENV['USER_PASSWORD'])
      click(@auth0_continue)
    end

    def wait_for_auth0_login_form
      wait_for(@auth0_login_form)
    end

    def get_login_url
      return @login_url
    end

    def wait_for_login_form
      wait_for(@login_form)
    end

    def login
      wait_for_login_form

      set(@email_input, ENV['USER_EMAIL'])
      set(@password_input, ENV['USER_PASSWORD'])
      click(@login_btn)
    end
	end
end

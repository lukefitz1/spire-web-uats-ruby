Before do
	case ENV['ENV']
		when 'local'
			@base_url = 'http://localhost:3000'
		when 'docker-local'
			@base_url = 'http://10.0.0.24:3000/'
		when 'test'
			@base_url = 'https://spire-art-services.herokuapp.com/'
		else
			puts 'No test env was set!'
			# Capybara.current_session.driver.quit
	end

	Capybara.current_session.driver.browser.manage.window.resize_to('1280', '800')
end

After do
	begin
	  Capybara.current_session.driver.quit
	rescue Selenium::WebDriver::Error::WebDriverError => e
	  puts("Browser shut down before instructed. Probably background wait. Ignoring. \n Exception: #{e}")
	end
end
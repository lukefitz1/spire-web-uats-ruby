require 'capybara/cucumber'
require 'selenium/webdriver'
require 'rspec/expectations'
require 'webdrivers'
require 'faker'
require 'dotenv/load'
require_relative '../../page_objects/require_all_page_objects'
require_relative '../../api/login'
require_relative '../../api/collection'
require_relative '../../api/customer'
require_relative '../../api/artist'
require_relative '../../api/general_information'
require_relative '../../api/artwork'
require 'json'

# Capybara.default_driver = :selenium # firefox
# Capybara.default_driver = :selenium_headless # headless firefox
# Capybara.default_driver = :selenium_chrome_headless

Capybara.default_driver = ENV['BROWSER'].to_sym
Capybara.default_selector = :css
Capybara.default_max_wait_time = 5

World(RSpec::Matchers)
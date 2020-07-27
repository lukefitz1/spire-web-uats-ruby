# frozen_string_literal: true

require 'rest-client'

Before do
  case ENV['ENV']
  when 'local'
    @base_url = 'http://localhost:3000/'
  when 'docker-local'
    @base_url = 'http://10.0.0.24:3000/'
  when 'staging'
    @base_url = 'https://staging-spire-art-services.herokuapp.com/'
  else
    Kernel.puts 'No test env was set!'
  end

  Capybara.current_session.driver.browser.manage.window.resize_to('1280', '800')
end

AfterConfiguration do
  File.delete('test.json') if File.exist?('test.json')
end

After do
  begin
    Capybara.current_session.driver.quit
  rescue Selenium::WebDriver::Error::WebDriverError => e
    Kernel.puts("Browser shut down before instructed. Probably background wait. Ignoring. \n Exception: #{e}")
  end
end

at_exit do
  if ENV['ENV'] == 'staging'
    s = File.read('test.json')
    obj = JSON.parse(s)

    suites = {}
    suites['suite'] = {
        description: 'Smoke Test',
        date: "#{Time.now.to_i}"
    }

    features = []
    obj.each do |test|
      feature = { feature_name: test['name'] }
      features.append(feature)

      scenarios = []
      steps = []
      unless test['elements'].empty?
        scenario = {}

        test['elements'].each do |element|
          scenario = { scenario_name: element['name'] } if element['type'] == 'scenario'
          scenarios.append(scenario)
          unless element['steps'].empty?
            element['steps'].each do |step|
              ENV['ERROR'] = '1' if step['result']['status'] == 'failed'
              step = { step_name: step['name'], result: step['result']['status'] }
              steps.append(step)
            end
          end
        end
        scenario['steps'] = steps
      end
      feature['scenarios'] = scenarios
    end

    remove_index = -1
    features.each do |feature|
      feature['scenarios'].each_with_index do |scenario, index|
        remove_index = index if scenario.empty?
      end

      feature['scenarios'].delete_at(remove_index) if remove_index != -1
    end

    suites['suite']['features'] = features
    send_results(suites)
  end
end

def send_results(suites)
  url = "#{ENV['TEST_RESULTS_API']}/api/suites/create_suite"
  headers = {
    'Content-Type': 'application/json',
    'x-api-key': ENV['TEST_RESULTS_API_KEY']
  }

  payload = suites.to_json
  RestClient.post(url, payload, headers)
end
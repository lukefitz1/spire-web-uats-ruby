# frozen_string_literal: true

require 'rest-client'

Before do
  case ENV['ENV']
  when 'local'
    @base_url = 'http://localhost:3000'
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
  s = File.read('test.json')
  obj = JSON.parse(s)

  features = []
  obj.each do |test|
    feature = { feature_name: test['name'] }
    features.append(feature)

    scenarios = []
    scenario = {}
    steps = []
    unless test['elements'].empty?
      test['elements'].each do |element|
        if element['type'] == 'scenario'
          scenario = { scenario_name: element['name'] }
        end
        scenarios.append(scenario)
        unless element['steps'].empty?
          element['steps'].each do |step|
            if step['result']['status'] == 'failed'
              ENV['ERROR'] = '1'
            end
            step = { step_name: step['name'], result: step['result']['status'] }
            steps.append(step)
          end
        end
      end
      scenario['steps'] = steps
    end
    feature['scenarios'] = scenarios
  end

    # send_results(features)
end

def send_results(features)
  url = "#{ENV['TEST_RESULTS_API_KEY']}/api/features/create_features"
  headers = {
    'Content-Type': 'application/json',
    'x-api-key': ENV['TEST_RESULTS_API_KEY']
  }

  payload = features.to_json
  RestClient.post(url, payload, headers)
end
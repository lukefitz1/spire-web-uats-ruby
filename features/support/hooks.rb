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
  unless ENV['ENV'] != 'local'
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
      unless test['elements'].empty?

        scenario = {}
        background_steps = {}
        test['elements'].each do |element|
          test_steps = []
          if element['type'] == 'background'
            unless element['steps'].empty?
              element['steps'].each do |test_step|
                step = { step_name: test_step['name'], result: test_step['result']['status'] }
                background_steps = step
              end
            end

          elsif element['type'] == 'scenario'
            scenario = { scenario_name: element['name'] }

            unless element['steps'].empty?
              element['steps'].each do |test_step|
                step = { step_name: test_step['name'], result: test_step['result']['status'] }
                test_steps.append(step)
              end
            end
          end


          if element['type'] == 'scenario'
            steps = test_steps.unshift(background_steps)
            scenario['steps'] = steps

            scenario_copy = scenario.dup
            scenarios.append(scenario_copy) unless scenario.empty?
          end
        end
        feature['scenarios'] = scenarios
      end
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
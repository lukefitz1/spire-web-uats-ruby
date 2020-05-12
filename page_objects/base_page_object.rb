require 'capybara/dsl'

module PageObjects
  class BasePageObject
    include Capybara::DSL

    def click(selector)
      find(selector, wait: 5).click
    end

    def wait_for(selector)
      has_css?(selector, wait: 5)
    end

    def wait_for_false(selector)
      has_css?(selector, visible: false, wait: 5)
    end

    def wait_for_with_error(selector)
      # raises error
      assert_selector(selector, wait: 5)
    end

    def wait_for_with_error_false(selector)
      assert_no_selector(selector, wait: 5)
    end

    def text(selector)
      find(selector).text
    end

    def set(selector, string)
      find(selector).set(string)
    end

    def get_base_url
      Controls::Shared::URLNavigationControl.get_base_url(:pmapp)
    end

    def build_link(url, business_alias)
      "#{self.get_base_url}#{business_alias}/#{url}"
    end

    def build_link_without_alias(url)
      "#{self.get_base_url}#{url}"
    end

    def has_no_selector(selector)
      has_no_selector?(selector)
    end

    def value(selector)
      find(selector).value
    end

    def switch_to_first_tab
      windows = page.driver.window_handles
      page.driver.switch_to_window(windows.first)
    end

    def refresh_page
      url = URI.parse(current_url)
      visit url
    end

  end
end
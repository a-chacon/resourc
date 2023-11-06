module LinkServices
  class TakeScreenshot
    include Capybara::DSL

    def initialize(link)
      @link = link
      configure_capybara
    end

    def run
      path = capture_screenshot
      image = resize_screenshot(path)
      attach_thumbnail(image)
    rescue StandardError => e
      handle_error(e)
    ensure
      reset_capybara
    end

    private

    def configure_capybara
      Capybara.run_server = false
      Capybara.default_driver = :selenium_headless
      Capybara.default_max_wait_time = 15
    end

    def capture_screenshot
      visit(@link.link)
      page.driver.browser.manage.window.resize_to(1280, 1024)
      path = "tmp/#{@link.title.parameterize}.png"

      begin
        sleep(5)
        page.driver.browser.save_screenshot(path)
        path
      rescue StandardError => e
        handle_screenshot_error(e)
        nil
      end
    end

    def resize_screenshot(path)
      image = MiniMagick::Image.open(path)
      image.resize '400x'
      resized_screenshot_path = 'tmp/resized_screenshot.png' # Use a temporary path
      image.write(resized_screenshot_path)
      resized_screenshot_path
    end

    def attach_thumbnail(image_path)
      @link.thumbnail.attach(io: File.open(image_path), filename: 'screenshot.png', content_type: 'image/png')
    end

    def reset_capybara
      Capybara.current_session.driver.quit
    end

    def handle_error(exception)
      Rails.logger.debug("Error: #{exception}")
    end

    def handle_screenshot_error(exception)
      Rails.logger.error("Failed to capture a screenshot: #{exception.message}")
    end
  end
end

require 'capybara'
require 'capybara/dsl'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium # Use Selenium as the driver
  config.app_host = 'http://localhost:3000' # Set your app's URL
end

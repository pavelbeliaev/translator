ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: 1)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end

driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('vcr_cassettes', __dir__)
  config.hook_into :webmock
  config.ignore_localhost = true
  config.ignore_hosts(*driver_hosts)
end

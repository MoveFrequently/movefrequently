ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr"
  config.hook_into :webmock
  config.filter_sensitive_data("<API_KEY>") { Rails.application.credentials.processor[:OPENAI_API_KEY] }
  config.allow_http_connections_when_no_cassette = false
  config.default_cassette_options = { record: ENV["VCR_RECORD_MODE"]&.to_sym || :none }
  config.ignore_localhost = true
end

module Factories
  def create_exercise(attributes = {})
    Exercise.create!({
      name: "Test Exercise",
      description: "A test exercise description",
      steps: [ "Step 1", "Step 2", "Step 3" ]
    }.merge(attributes))
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Add more helper methods to be used by all tests here...
    include Factories
  end
end

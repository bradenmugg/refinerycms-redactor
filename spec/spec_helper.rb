require 'rubygems'

# Configure Rails Environment
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'refinerycms-testing'
require 'capybara/rspec'

require 'selenium-webdriver'
Capybara.javascript_driver = :selenium

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.extend Refinery::Testing::ControllerMacros::Authentication, type: :controller
  config.extend Refinery::Testing::FeatureMacros::Authentication, type: :feature
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories including factories.
([Rails.root.to_s] | ::Refinery::Plugins.registered.pathnames).map{|p|
  Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
}.flatten.sort.each do |support_file|
  require support_file
end

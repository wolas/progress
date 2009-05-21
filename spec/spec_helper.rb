# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" unless defined?(RAILS_ROOT)
require 'spec/autorun'
require 'spec/rails'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  #
  # For more information take a look at Spec::Runner::Configuration and Spec::Runner
end

def new_project options = {}
  Project.new( project_params options )
end

def project_params options = {}
  {:name => 'test_project', :end_date => Date.tomorrow, :colour => '#333333'}.merge(options)
end

def new_task options = {}
  Task.new( task_params({:project => new_project}.merge(options)) )
end

def task_params options = {}
  {:end_date => Date.tomorrow, :start_date => (Date.today + 1), :name => 'foo', :description => 'test'}.merge(options)
end

def new_user options = {}
  User.new user_params(options)
end

def user_params options = {}
  {:login => 'test_user', :password => 'test', :password_confirmation => 'test', :email => 'foo@bar.com'}.merge(options)
end

def new_event options = {}
  Event.new event_params(options)
end

def event_params options = {}
  {:date => (Date.today + 1), :name => 'foo', :description => 'test'}.merge(options)
end

require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'

  unless ENV['DRB']
    require 'simplecov'
    require 'simplecov-rcov'
    SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
    SimpleCov.start 'rails' if ENV["COVERAGE"]
  end

  Capybara.configure do |c|
    c.default_driver = :selenium
    c.current_driver = :selenium
    c.javascript_driver = :webkit
  end
end

Spork.each_run do
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  if ENV['DRB']
    require 'simplecov'
    require 'simplecov-rcov'
    SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
    SimpleCov.start 'rails' if ENV["COVERAGE"]
  end

  RSpec.configure do |config|
    config.include AuthHelper, :type => :controller
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    #config.use_transactional_fixtures = true
    config.use_transactional_fixtures = false
    DatabaseCleaner.strategy = :truncation
    config.before(:each) do
      if example.metadata[:non_transactional] || example.metadata[:js] || example.metadata[:type] == :request
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
      end

      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    #config.order = "random"

    require 'factory_girl'
  end

end

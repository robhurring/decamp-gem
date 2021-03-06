require 'bundler/setup'
Bundler.require(:default, :test)

require File.expand_path("../../lib/decamp", __FILE__)
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each{ |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.mock_with :mocha
  config.order = 'random'
end

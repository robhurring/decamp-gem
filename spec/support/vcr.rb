_hour = 60*60
_day = _hour*24

VCR.configure do |c|
  c.cassette_library_dir = 'spec/data/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.configure_rspec_metadata!
  c.default_cassette_options = {re_record_interval: (_day * 7)}
end

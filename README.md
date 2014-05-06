# Decamp

This is a small scraper for the decamp.com bus schedules. It is a hack right now since their HTML is a bit of a mess and I'm trying to play around and see how consistent I can get some of it.

## Installation

Add this line to your application's Gemfile:

    gem 'decamp', github: 'robhurring/decamp-gem'

And then execute:

    $ bundle

## Usage

#### Grabbing a specific route's timetable

```ruby
# build our new york to west caldwell schedule
schedule = Decamp::Schedule.new('NY-WC')

# scrape decamp.com to pull back the data
response = schedule.fetch

if response.ok?
  puts response.title     # => "New York to West Caldwell"
  puts response.stops     # => ["NYC P/A Bus Terminal", "NUTLEY: Darling & Kingsland (E)", ...]

  # grab the timetable for this bus schedule
  timetable = response.timetable

  # find out when the bus stops at "NUTLEY: Darling & Kingsland (E)"
  route_name = "NUTLEY: Darling & Kingsland (E)"
  times = timetable.map{ |route| route[route_name] }
  pp times
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

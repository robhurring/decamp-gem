module Decamp
  class Schedule
    include HTTParty
    base_uri 'decamp.com'
    parser Decamp::Parser::Nokogiri
    format :nokogiri

    # Public: Create a scraper for a decamp route.
    #
    # route   - The route key from decamp (example: NY-WC)
    # day     - The day (0 = weekday, 1 = weekend/holiday)
    # time    - The time of day (M = all day, AM = am, PM = pm)
    #
    # Returns a scraper, ready to go.
    def initialize(route, day: 0, time: 'M')
      @route, @day, @time = route, day, time
    end

    # Public: Fetch the HTML for the given route/time. This will wrap the
    #         HTTParty response in a custom response class, which is looked
    #         up by the route key. The default response is Decamp::Response::Generic
    #
    # Returns a response object containing the nokogiri document
    def fetch
      options = {
        query: {
          f_route: @route,
          f_day: @day,
          f_time: @time
        }
      }

      response = self.class.get '/printRoute.asp', options
      wrap_response(response, options)
    end

    # Public: Wraps the httparty response in our custom response wrapper.
    #
    # httparty_response   - The raw httparty response
    # options             - The options used during the request
    #
    # Examples
    #
    #   scraper.wrap_response(response, {})
    #   # => #<MyCustomResponse:0x00...>
    #
    # Returns the wrapped response
    def wrap_response(httparty_response, options = {})
      response_class = Decamp.wrapper_for_route(@route)
      response_class.new(httparty_response, options)
    end
  end
end
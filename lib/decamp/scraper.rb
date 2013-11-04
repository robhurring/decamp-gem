module Decamp
  class Scraper
    include HTTParty
    base_uri 'decamp.com'
    parser Decamp::Parser::Nokogiri
    format :nokogiri

    def initialize(route, day=0, time='M')
      @route, @day, @time = route, day, time
    end

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

    def wrap_response(httparty_response, options = {})
      response_class = Decamp.wrapper_for_route(@route)
      response_class.new(httparty_response, options)
    end
  end
end
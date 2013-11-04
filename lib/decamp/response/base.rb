module Decamp
  module Response
    class Base
      attr_reader :response, :route, :day, :time

      def initialize(httparty_response, options = {})
        @response = httparty_response
        @route = options[:f_route]
        @day = options[:f_day]
        @time = options[:f_time]
      end

      def ok?
        response.ok?
      end

      def title
        @title ||= response.xpath('//table[1]/tr[1]').text.strip
      end

      def stops
        @stops ||= response.xpath('//table[1]/tr[2]/td').map{ |node| node.text.strip }
      end

      def routes
        @routes ||= begin
          response.xpath('//table[1]/tr[position()>2]').map do |route| 
            route.xpath('./td').map{ |node| node.text.strip }
          end
        end
      end

      def timetable
        @timetable ||= begin
          routes.map{ |r| Hash[stops.zip(r)] }
        end
      end
    end
  end
end

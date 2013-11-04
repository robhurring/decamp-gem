module Decamp
  module Response
    # A generic response wrapper for a schedule page, This can be considered.
    # a base class for any custom parsing that needs to take place
    class Generic
      attr_reader :response, :route, :day, :time

      # Public: Instantiate a new response
      #
      # httparty_response  - The raw response from HTTParty
      # options            - The options used to fetch this HTML
      #
      # Returns the response, wrapped with the custom table parsers
      def initialize(httparty_response, options = {})
        @response = httparty_response
        @route = options[:f_route]
        @day = options[:f_day]
        @time = options[:f_time]
      end

      # Public: Was the request ok? (http 200).
      #
      # Returns true if was 200, false otherwise
      def ok?
        response.ok?
      end

      # Public: The schedule title.
      # Returns the title for the schedule
      def title
        @title ||= clean_text(response.xpath('//table[1]/tr[1]'))
      end

      # Public: The schedule's stop names.
      # Returns an array of stop names
      def stops
        @stops ||= response.xpath('//table[1]/tr[2]/td').map{ |node| clean_text(node) }
      end

      # Public: The single route line for the schedule
      # Returns an 2-dimensional array of stop times
      def routes
        @routes ||= begin
          response.xpath('//table[1]/tr[position()>2]').map do |route| 
            route.xpath('./td').map{ |node| clean_text(node) }
          end
        end
      end
      
      # Public: Creates a rough timetable in a hash by mashing stop names
      #         to stop times
      # Returns a hash of {STOP_NAME => STOP_TIME}
      def timetable
        @timetable ||= begin
          routes.map{ |r| Hash[stops.zip(r)] }
        end
      end

      # Public: The schedule's special info key (at the bottom of the page)
      # Returns a hash of what the "Special Info" column contains
      def special
        @special ||= begin
          # nokogiri handles &nbsp's weird, so we need to gsub these out
          nbsp = Nokogiri::HTML("&nbsp;").text

          data = response.xpath('//table[2]/tr').map do |row|
            key = clean_text(row.xpath('./td[1]')).gsub(nbsp, '')
            value = clean_text(row.xpath('./td[2]')).gsub(nbsp, '')

            [key, value]
          end
          Hash[data]
        end
      end

    protected

      # Protected: Cleans up some nodes/text to normalize them.
      #
      # node_or_string  - A nokogiri node, or a string.
      #
      # Returns the text stripped
      def clean_text(node_or_string)
        node_or_string = node_or_string.text if node_or_string.respond_to?(:text)
        node_or_string.strip
      end
    end
  end
end

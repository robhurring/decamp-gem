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
        @title ||= clean_text(response.xpath('//table[1]/tr[1]'))
      end

      def stops
        @stops ||= response.xpath('//table[1]/tr[2]/td').map{ |node| clean_text(node) }
      end

      def routes
        @routes ||= begin
          response.xpath('//table[1]/tr[position()>2]').map do |route| 
            route.xpath('./td').map{ |node| clean_text(node) }
          end
        end
      end

      def timetable
        @timetable ||= begin
          routes.map{ |r| Hash[stops.zip(r)] }
        end
      end

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

      def clean_text(node_or_string)
        node_or_string = node_or_string.text if node_or_string.respond_to?(:text)
        node_or_string.strip
      end
    end
  end
end

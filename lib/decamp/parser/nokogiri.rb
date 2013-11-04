module Decamp
  module Parser
    class Nokogiri < ::HTTParty::Parser
      SupportedFormats['text/html'] = :nokogiri

      def nokogiri
        ::Nokogiri::HTML(body)
      end
    end
  end
end
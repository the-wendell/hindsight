module ApiUtils
  module Services
    class ParseCaptionImageResponse < ::Services::Base
      def initialize(response)
        @response = JSON.parse(response)
      end

      def call
        parsed_response
      end

      private

      attr_reader :response

      def parsed_response
        success? ? url : error_message
      end

      def success?
        response['success'] == true
      end

      def error_message
        response['error_message']
      end

      def url
        response['data']['url']
      end
    end
  end
end
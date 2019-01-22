module ApiUtils
  module Services
    class ParseEodResponse < ::Services::Base
      def initialize(response_body)
        @response_body = JSON.parse(response_body)
      end

      def call
        OpenStruct.new(
          all: days,
          oldest: days[-1],
          most_recent: days[0]
        )
      end

      private

      attr_reader :response_body

      def column_names
        @column_names ||= response_body['dataset']['column_names']
      end

      def days
        response_body['dataset']['data'].map do |day|
          build_day(day)
        end
      end

      def build_day(day)
        column_names.each_with_object(OpenStruct.new).with_index do |(name, struct), index|
          struct.public_send("#{name.downcase}=", format_value(day[index]))
        end
      end

      def format_value(value)
        return value unless value.is_a? Integer

        BigDecimal(value)
      end
    end
  end
end
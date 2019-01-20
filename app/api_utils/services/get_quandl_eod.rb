module ApiUtils
  module Services
    class GetQuandlEod < ::Services::Base
      BASE_URL = 'https://www.quandl.com/api/v3/datasets/EOD/'.freeze
      API_KEY = ENV['api_key']

      def initialize(target_date, stock)
        @target_date = target_date
        @stock = stock
      end

      def call
        HTTParty.get(api_call).body
      end

      private

      attr_reader :target_date, :stock

      def api_call
        BASE_URL + stock_code + start_date + end_date + api_key
      end

      def end_date
        Time.new.yield_self { |t| "end_date=#{t.year}-#{t.month}-#{t.day}&" }
      end

      def start_date
        "start_date=#{target_date}&"
      end

      def api_key
        "api_key=#{API_KEY}"
      end

      def stock_code
        "#{stock}?"
      end
    end
  end
end
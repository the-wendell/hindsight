module StockMetrics
  module Calculators
    class TotalReturn < ::Services::Base
      def initialize(initial_price, final_price, dividends)
        @initial_price = initial_price
        @final_price = final_price
        @dividends = dividends
      end

      def call
        calculate_total_return
      end

      private

      attr_reader :initial_price, :final_price, :dividends

      def calculate_total_return
        (final_price - initial_price + total_dividends) / initial_price
      end

      def total_dividends
        dividends.inject(:+)
      end
    end
  end
end
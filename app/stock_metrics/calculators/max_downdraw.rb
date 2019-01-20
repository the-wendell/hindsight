module StockMetrics
  module Calculators
    class MaxDowndraw < ::Services::Base
      def initialize(closing_prices)
        @closing_prices = closing_prices
      end

      def call
        calculate_max_down_draw
      end

      private

      attr_reader :closing_prices

      def calculate_max_down_draw
        (find_from_peak(closing_prices, []) + find_from_trough(closing_prices, [])).min
      end

      def find_from_peak(prices, downdraws)
        peak_index = prices.index(prices.max)
        trough_index = prices.index(prices[0..peak_index].min)

        return downdraws if peak_index == trough_index

        downdraws << calculate_downdraw(prices[peak_index], prices[trough_index])
        find_from_peak(prices[0..trough_index], downdraws)
      end

      def find_from_trough(prices, downdraws)
        trough_index = prices.index(prices.min)
        peak_index = prices.index(prices[trough_index..-1].max)

        return downdraws if trough_index == peak_index

        downdraws << calculate_downdraw(prices[peak_index], prices[trough_index])
        find_from_trough(prices[peak_index..-1], downdraws)
      end

      def calculate_downdraw(peak, trough)
        (trough - peak) / peak
      end
    end
  end
end
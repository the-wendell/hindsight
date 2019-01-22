module StockMetrics
  module Calculators
    class MaxDowndraw < ::Services::Base
      def initialize(closing_prices)
        @closing_prices = closing_prices
      end

      def call
        calculate_max_down_draw || 0.0
      end

      private

      attr_reader :closing_prices

      def calculate_max_down_draw
        (find_from_peak(closing_prices, []) + find_from_trough(closing_prices, [])).min
      end

      def find_from_peak(prices, downdraws)
        arr = split_prices_on(:peak, prices)
        return downdraws if arr.length <= 1

        peak_index = -1
        trough_index = arr.rindex(arr.min)

        downdraws << calculate_downdraw(arr[peak_index], arr[trough_index])

        find_from_peak(arr[0..trough_index], downdraws)
      end

      def find_from_trough(prices, downdraws)
        arr = split_prices_on(:trough, prices)
        return downdraws if arr.length <= 1

        trough_index = 0
        peak_index = arr.index(arr.max)

        downdraws << calculate_downdraw(arr[peak_index], arr[trough_index])

        find_from_trough(arr[peak_index..-1], downdraws)
      end

      def split_prices_on(type, prices)
        case type
        when :trough
          split_index = prices.index(prices.min)
          prices[split_index..-1]
        when :peak
          split_index = prices.rindex(prices.max)
          prices[0..split_index]
        end
      end

      def calculate_downdraw(peak, trough)
        (trough - peak) / peak
      end
    end
  end
end
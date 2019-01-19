module StockMetrics
  module Services
    class Calculator < ::Services::Base
      def initialize(days)
        @days = days
      end

      def call
        OpenStruct.new(
          total_return: total_return,
          max_downdraw: max_downdraw
        )
      end

      private

      attr_reader :days

      def total_return
        (ending_price - initial_price + dividends) / initial_price
      end

      def max_downdraw
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

      def ending_price
        days.most_recent.close
      end

      def initial_price
        @initial_price ||= days.oldest.close
      end

      def dividends
        days.all.inject(0) { |total, day| total + day.dividend }
      end

      def closing_prices
        @closing_prices ||= days.all.map(&:close)
      end
    end
  end
end
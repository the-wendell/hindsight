module StockMetrics
  module ValueObjects
    class EodHistory
      def initialize(days)
        @days = days
      end

      def total_return
        Calculators::TotalReturn.call(initial_price, final_price, dividends)
      end

      def max_downdraw
        Calculators::MaxDowndraw.call(closing_prices)
      end

      def final_price
        days.most_recent.close
      end

      def initial_price
        days.oldest.close
      end

      def dividends
        days.all.map(&:dividend)
      end

      def closing_prices
        days.all.map(&:close)
      end

      private

      attr_reader :days
    end
  end
end
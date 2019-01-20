module StockMetrics
  class HistoryCalculations
    def initialize(calculation_values)
      @calculation_values = calculation_values
    end

    def max_downdraw
      Calculators::MaxDowndraw.call(
        calculation_values.closing_prices
      )
    end

    def total_return
      Calculators::TotalReturn.call(
        calculation_values.initial_price,
        calculation_values.final_price,
        calculation_values.dividends
      )
    end

    private

    attr_reader :calculation_values
  end
end
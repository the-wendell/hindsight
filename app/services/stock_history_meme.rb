module Services
  class StockHistoryMeme < Base
    def initialize(date, stock)
      @date = date
      @stock = stock
    end

    def call
      link_to_results_meme
    end

    private

    attr_reader :date, :stock

    def link_to_results_meme
      ApiUtils::ImageflipApi.post_caption_image(captions.one, captions.two)
    end

    def calculation_results
      @calculation_results ||= StockMetrics::ValueObjects::EodHistory.new(quandl_api_results)
        .yield_self { |values| StockMetrics::HistoryCalculations.new(values) }
        .yield_self { |results| calculation_results_struct(results) }
    end

    def quandl_api_results
      ApiUtils::QuandlApi.get_eod_stock_price_history(date, stock)
    end

    def calculation_results_struct(results)
      OpenStruct.new(
        total_return: format_percentage(results.total_return),
        max_downdraw: format_percentage(results.max_downdraw)
      )
    end

    def captions
      @captions ||= OpenStruct.new(
        one: "#{stock} Total Return: #{calculation_results.total_return}%",
        two: "#{stock} Max Drawdown: #{calculation_results.max_downdraw}%"
      )
    end

    def format_percentage(value)
      (value * 100).round(2)
    end
  end
end
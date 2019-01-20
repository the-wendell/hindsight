module ApiUtils
  class QuandlApi
    class << self
      def get_eod_stock_price_history(date, stock)
        Services::GetQuandlEod.call(date, stock)
          .yield_self { |response| Services::ParseEodResponse.call(response) }
      end
    end
  end
end
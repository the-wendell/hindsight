require_relative '../../spec_dependencies'

describe StockMetrics::ValueObjects::EodHistory do
  let(:days) do
    OpenStruct.new(
      oldest: day_structs.last,
      most_recent: day_structs.first,
      all: day_structs
    )
  end
  let(:day_structs) do
    [
      OpenStruct.new(close: 5, dividend: 1),
      OpenStruct.new(close: 10, dividend: 2),
      OpenStruct.new(close: 20, dividend: 3),
    ]
  end
  let(:eod_history) { described_class.new(days) }

  describe '#final_price' do
    it 'returns the closing price of the most recent day' do
      expect(eod_history.final_price).to eq(5)
    end
  end

  describe '#initial_price' do
    it 'returns the closing price of the oldest day' do
      expect(eod_history.initial_price).to eq(20)
    end
  end

  describe '#dividends' do
    it 'it returns an array of all dividends' do
      expect(eod_history.dividends).to eq([1, 2, 3])
    end
  end

  describe '#closing_prices' do
    it 'returns an array of all closing prices in order from newest to oldest' do
      expect(eod_history.closing_prices).to eq([5, 10, 20])
    end
  end
end
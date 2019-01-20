require_relative '../../spec_dependencies'

describe StockMetrics::Calculators::MaxDowndraw do
  let(:closing_prices_1) { [100.0, 90.0, 110.0, 105.0, 101.0, 60.0, 103.0] }
  let(:closing_prices_2) { [100.0, 90.0, 110.0, 115.0, 103.0, 89.0, 115.0] }

  it 'calculates the max downdraw' do
    expect(described_class.call(closing_prices_1)).to eq((60.0 - 103.0) / 103.0)
    expect(described_class.call(closing_prices_2)).to eq((89.0 - 115.0) / 115.0)
  end
end
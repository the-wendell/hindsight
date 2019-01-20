require_relative '../../spec_dependencies'

describe ApiUtils::Services::GetQuandlEod do
  let(:start_date) { '2018-12-20' }
  let(:end_date) { Time.new.yield_self { |t| "#{t.year}-#{t.month}-#{t.day}" } }
  let(:api_key) { ENV['api_key'] }
  let(:stock) { 'HD' }
  let(:correct_url) do
    "https://www.quandl.com/api/v3/datasets/EOD/#{stock}?start_date=#{start_date}&end_date=#{end_date}&api_key=#{api_key}"
  end

  before do
    allow(HTTParty).to receive(:get).with(correct_url).and_return(OpenStruct.new(body: 'success'))
  end

  it 'formats api_call correctly' do
    expect(described_class.call(start_date, stock)).to eq('success')
  end
end
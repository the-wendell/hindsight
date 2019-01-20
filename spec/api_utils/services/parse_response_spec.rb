require_relative '../../spec_dependencies'

describe ApiUtils::Services::ParseEodResponse do
  let(:response_body) do
    {
      'dataset' => {
        'column_names' => %w[Open Close],
        'data' => [[5, 6], [7, 8], [9, 10]]
      }
    }.to_json
  end
  let(:expected_results) do
    [
      OpenStruct.new(open: 5, close: 6),
      OpenStruct.new(open: 7, close: 8),
      OpenStruct.new(open: 9, close: 10)
    ]
  end

  it 'converts the response into an array of OpenStructs' do
    result = described_class.call(response_body)

    expect(result.all).to eq(expected_results)
    expect(result.oldest).to eq(expected_results[-1])
    expect(result.most_recent).to eq(expected_results[0])
  end
end
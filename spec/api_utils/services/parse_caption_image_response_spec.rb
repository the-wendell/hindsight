require_relative '../../spec_dependencies'

describe ApiUtils::Services::ParseCaptionImageResponse do
  let(:successful_response) { { success: true, data: { url: 'url' } }.to_json }
  let(:unsuccessful_response) { { success: false, error_message: 'error_message' }.to_json }

  context 'when successful' do
    it 'returns a url' do
      expect(described_class.call(successful_response)).to eq('url')
    end
  end

  context 'when not successful' do
    it 'returns an error message' do
      expect(described_class.call(unsuccessful_response)).to eq('error_message')
    end
  end
end
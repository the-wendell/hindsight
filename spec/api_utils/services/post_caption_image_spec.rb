require_relative '../../spec_dependencies'

describe ApiUtils::Services::PostCaptionImage do
  let(:caption_one) { 'caption_one' }
  let(:caption_two) { 'caption_two' }
  let(:url) { described_class::URL }
  let(:body) do
    {
      template_id: described_class::DEFAULT_IMAGE_ID,
      username: described_class::USERNAME,
      password: described_class::PASSWORD,
      text0: caption_one,
      text1: caption_two
    }
  end

  before do
    allow(HTTParty).to receive(:post).with(url, body: body).and_return(OpenStruct.new(body: 'success'))
  end

  it 'formats api_call correctly' do
    expect(described_class.call(caption_one, caption_two)).to eq('success')
  end
end
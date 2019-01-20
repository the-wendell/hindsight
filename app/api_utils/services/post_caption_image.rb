module ApiUtils
  module Services
    class PostCaptionImage < ::Services::Base
      DEFAULT_IMAGE_ID = '61544'.freeze
      URL = 'https://api.imgflip.com/caption_image'.freeze
      PASSWORD = ENV['imgflip_password']
      USERNAME = ENV['imgflip_username']

      def initialize(caption_one, caption_two)
        @caption_one = caption_one
        @caption_two = caption_two
      end

      def call
        HTTParty.post(URL, body: body).body
      end

      private

      attr_reader :caption_one, :caption_two

      def body
        {
          template_id: DEFAULT_IMAGE_ID,
          username: USERNAME,
          password: PASSWORD,
          text0: caption_one,
          text1: caption_two
        }
      end
    end
  end
end
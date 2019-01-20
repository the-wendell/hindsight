module ApiUtils
  class ImageflipApi
    class << self
      def post_caption_image(caption_one, caption_two)
        Services::PostCaptionImage.call(caption_one, caption_two)
          .yield_self { |response| Services::ParseCaptionImageResponse.call(response) }
      end
    end
  end
end
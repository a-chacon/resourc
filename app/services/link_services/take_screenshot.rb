module LinkServices
  class TakeScreenshot
    def initialize(link: Link)
      @link = link
    end

    def run
      response = HTTP.get("https://url2screenshot.fly.dev?api_key=#{Rails.application.credentials.dig(:url2screenshot,
                                                                                                      :api_key)}&url=#{@link.link}")
      if response.code == 200
        # Create a temporary file to save the image
        temp_file = Tempfile.new(['image', '.png'])
        temp_file.binmode

        # Write the image content to the temporary file
        temp_file.write(response.body)

        # Close the file to ensure it's saved
        temp_file.close
      else
        p response
        Rails.logger.debug 'Failed to query the screenshot'
      end

      generate_blurhash(temp_file.path)
      attach_thumbnail(temp_file.path)
    rescue StandardError => e
      handle_error(e)
    end

    private

    def attach_thumbnail(image_path)
      @link.thumbnail.attach(io: File.open(image_path), filename: 'screenshot.png', content_type: 'image/png')
    end

    def generate_blurhash(image_path)
      image = MiniMagick::Image.open(image_path)

      @link.update(blurhash: Blurhash.encode(image.width, image.height, image.get_pixels.flatten))
    end

    def handle_error(exception)
      Rails.logger.debug("Error: #{exception}")
    end
  end
end

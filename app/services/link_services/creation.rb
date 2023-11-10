module LinkServices
  class Creation
    def initialize(link: {}, tags: [], user: {})
      @link = Link.new(link)
      @user = user
      @tags = tags || []
    end

    def run
      @link.users << @user

      @link.tags << @tags.uniq.map { |t| Tag.find_or_create_by(name: t.downcase) }

      GenerateLinkThumbnailJob.perform_later(@link) if @link.save

      @link
    end
  end
end

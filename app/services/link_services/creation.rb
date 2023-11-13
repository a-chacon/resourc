module LinkServices
  class Creation
    def initialize(link: Link, tags: [], user: {})
      @link = Link.new(link)
      @user = user
    end

    def run
      @link.users << @user

      CompleteLinkDataJob.perform_later(link: @link) if @link.save

      @link
    end
  end
end

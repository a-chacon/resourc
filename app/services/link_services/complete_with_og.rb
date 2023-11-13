module LinkServices
  class CompleteWithOg
    def initialize(link: Link)
      @link = link
    end

    def run
      response = GetOg.new(link: @link.link).run

      @link.title = response.title
      @link.description = response.description
      @link
    end
  end
end

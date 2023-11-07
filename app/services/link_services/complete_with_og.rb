module LinkServices
  class CompleteWithOg
    def initialize(link)
      @link = link
    end

    def run
      og = OpenGraph.new(@link.link)
      @link.update(title: og.title, description: og.description)
    end
  end
end

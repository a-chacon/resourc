class GetOg
  def initialize(link: '')
    @link = link
  end

  def run
    og = OpenGraph.new(@link)

    OpenStruct.new({ title: og.title, description: og.description })
  end
end

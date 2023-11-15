module LinkServices
  class Creation
    def initialize(link: Link, tags: [], user: User)
      @list_id = link.delete(:list)
      @link = Link.new(link)
      @user = user
    end

    def run
      @link.users << @user

      begin
        @link.lists << List.find(@list_id)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end

      CompleteLinkDataJob.perform_later(link: @link) if @link.save

      @link
    end
  end
end

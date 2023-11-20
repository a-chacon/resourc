class ReadmeToListJob < ApplicationJob
  queue_as :default

  def perform(readme_url: '', list_title: '', list_description: '')
    links = ReadmeScraper.scrape_readme(readme_url)
    p links.count
    list = List.find_or_create_by(title: list_title,
                                  description: list_description)
    list.users << User.first if list.users.empty?

    links.each do |l|
      @link = LinkServices::CompleteWithOg.new(link: Link.find_or_initialize_by(link: l)).run
      @link.users << User.first if @link.users.empty?
      if @link.id.nil?
        @link.save
        CompleteLinkDataJob.perform_now(link: @link)
      end

      list.links << @link unless list.links.exists? @link.id
    rescue ActiveRecord::RecordInvalid => e
      p 'Link invalid ' + e.to_s
    end
  end
end

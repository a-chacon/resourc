namespace :readme do
  desc 'Scrape links from a README file'
  task :scrape_links, [:readme_url] => :environment do |_task, args|
    readme_url = args[:readme_url]
    ReadmeScraper.scrape_readme(readme_url)
  end

  desc 'Scrape links from a README file'
  task :create_list, %i[readme_url list_title list_description] => :environment do |_task, args|
    readme_url = args[:readme_url]
    links = ReadmeScraper.scrape_readme(readme_url)
    p links.count
    list = List.find_or_create_by(title: args[:list_title],
                                  description: args[:list_description])
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

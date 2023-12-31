# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://resourc.tech'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  Tag.select('tags.*, COUNT(links_tags.link_id) AS link_count')
     .joins(:links)
     .group('tags.id')
     .order('link_count DESC')
     .limit(100).each do |tag|
    add "/tags/#{tag.slug}", lastmod: tag.links.last.created_at
  end

  List.where(public: true).each do |l|
    add "/lists/#{l.slug}", lastmod: l.links.last.created_at
  end
end

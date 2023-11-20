# lib/readme_scraper.rb
require 'http'

class ReadmeScraper
  def self.extract_links(text_content, excluded_extensions = [])
    links = text_content.scan(%r{https?://[^\s"'<>)\]]+})
    links.reject { |link| excluded_extensions.any? { |ext| link.end_with?(ext) } }
  end

  def self.scrape_readme(readme_url)
    response = HTTP.get(readme_url)
    readme_content = response.body.to_s

    excluded_extensions = ['.svg', '.png']
    extract_links(readme_content, excluded_extensions)
  rescue StandardError => e
    puts "Error: #{e.message}"
  end
end

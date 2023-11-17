class Remove404LinksJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Link.all.each_with_index do |l, _index|
      p "LinK: #{l.link}"
      response = HTTP.get(l.link)
      l.destroy if response.code == 404
    rescue HTTP::ConnectionError => e
      Rails.logger.debug e.to_s
      l.destroy
    end
  end
end

class Remove404LinksJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    Link.all.each_with_index do |l, _index|
      p "LinK: #{l.link}"
      response = HTTP.timeout(30).get(l.link)
      l.destroy if response.code == 404
    rescue StandardError => e
      Rails.logger.debug e.to_s
      l.destroy
    end
  end
end

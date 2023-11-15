class CheckLinkHealthJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform(*_args)
    Link.oldest_10.each_with_index do |l, _index|
      response = HTTP.get(l.link)
      if response.code == 200
        link = LinkServices::CompleteWithOg.new(link: l).run
        link = LinkServices::AiAnalyze.new(link:).run
      else
        l.enqueue_to_delete!
      end
    rescue HTTP::ConnectionError => e
      Rails.logger.debug e.to_s
      l.enqueue_to_delete!
    end
  end
end

class CompleteLinkDataJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform(link: Link)
    link = LinkServices::AiAnalyze.new(link:).run

    return if link.need_review?

    LinkServices::TakeScreenshot.new(link:).run

    link.active!

    LinkServices::ShareOnDiscordChannels.new(link:).run
  end
end

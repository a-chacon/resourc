class GenerateLinkThumbnailJob < ApplicationJob
  include SuckerPunch::Job
  queue_as :default

  def perform(link)
    LinkServices::TakeScreenshot.new(link).run
  end
end

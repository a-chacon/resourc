class ApplicationController < ActionController::Base
  layout 'main'

  include Imageomatic::Opengraph
  include Pagy::Backend

  before_action :assign_opengraph_data
  around_action :switch_locale
  before_action :set_q

  def set_q
    @q = Link.ransack(params[:q])
    @q.sorts = ['created_at desc', 'reaction_like desc'] if @q.sorts.empty?
  end

  def switch_locale(&action)
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{locale}'"
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def assign_opengraph_data
    opengraph.title = "#{t('title')}"
    opengraph.description = t('description')
    opengraph.image = 'https://resourc.tech/opengraph.png'
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  rescue StandardError
    'en'
  end
end

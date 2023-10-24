class ApplicationController < ActionController::Base
  include Imageomatic::Opengraph
  include Pagy::Backend

  before_action :assign_opengraph_data
  around_action :switch_locale

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
    opengraph.title = '2048 Devs: Comparte, Aprende y Crea'
    opengraph.description = 'Comparte tus hallazgos, aprende de otros y juntos creemos un ambiente de colaboración. Artículos, herramientas, proyectos de código abierto: ¡todo es bienvenido! '
    opengraph.image = 'https://2048.fly.dev/2048.webp'
  end

  def terms; end

  def privacy; end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end

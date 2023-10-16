class ApplicationController < ActionController::Base
  include Imageomatic::Opengraph
  include Pagy::Backend

  before_action :assign_opengraph_data

  def assign_opengraph_data
    opengraph.title = '2048 Devs: Comparte, Aprende y Crea'
    opengraph.description = 'Comparte tus hallazgos, aprende de otros y juntos creemos un ambiente de colaboración. Artículos, herramientas, proyectos de código abierto: ¡todo es bienvenido! '
    opengraph.image = 'https://2048.fly.dev/2048.webp'
  end

  def terms; end

  def privacy; end
end

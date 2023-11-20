class LinksController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!, only: %i[create new]
  before_action :authorize, only: %i[index show]
  before_action :set_link, only: [:show]

  def show
    return render layout: 'layouts/main' unless @current_user

    @current_user_reactions = @current_user.user_links.where(relationship_type: %i[like
                                                                                   dislike]).where(link_id: @link.id)
    render layout: 'layouts/main'
  end

  # GET /links or /links.json
  def index
    @page_title = t('meta_title')
    @page_description = t('meta_description')

    @pagy, @records = pagy(@q.result(distinct: true).active.with_attached_thumbnail.includes(:tags,
                                                                                             user_links: { user: { avatar_attachment: :blob } }))

    return render layout: 'layouts/main_links' unless @current_user

    @current_user_reactions = @current_user.user_links.where(relationship_type: %i[like
                                                                                   dislike]).where(link_id: @records.pluck(:id))
    render layout: 'layouts/main_links'
  end

  # GET /links/new
  def new
    @link = Link.new
    return unless params[:link]

    @link.link = params[:link]
    @link = LinkServices::CompleteWithOg.new(link: @link).run
  end

  # POST /links or /links.json
  def create
    @link = LinkServices::Creation.new(link: link_params, user: @current_user).run

    if !@link.errors.any?
      redirect_to root_path, notice: t('links.create.successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def open_graph
    response = GetOg.new(link: params[:url]).run

    render json: response.to_h.to_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.fetch(:link, {}).permit(:title, :description, :link, :list)
  end
end

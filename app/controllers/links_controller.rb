class LinksController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!, only: %i[create new]
  before_action :authorize, only: [:index]

  # GET /links or /links.json
  def index
    @page_title = t('meta_title')
    @page_description = t('meta_description')

    @popular_tags = Tag.select('tags.*, COUNT(links_tags.link_id) AS link_count')
                       .joins(:links)
                       .group('tags.id')
                       .order('link_count DESC')
                       .limit(15)

    @q = Link.ransack(params[:q])
    @q.sorts = ['created_at desc', 'reaction_like desc'] if @q.sorts.empty?

    @pagy, @records = pagy(@q.result(distinct: true).with_attached_thumbnail.includes(:tags,
                                                                                      user_links: { user: { avatar_attachment: :blob } }))

    return unless @current_user

    @current_user_reactions = @current_user.user_links.where(relationship_type: %i[like
                                                                                   dislike]).where(link_id: @records.pluck(:id))
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # POST /links or /links.json
  def create
    @link = LinkServices::Creation.new(link: link_params, tags: params[:tags], user: @current_user).run

    if !@link.errors.any?
      redirect_to root_path, notice: t('links.create.successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def open_graph
    og = OpenGraph.new(params[:url])
    render json: {
      title: og.title,
      description: og.description
    }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.fetch(:link, {}).permit(:title, :description, :link, :kind)
  end
end

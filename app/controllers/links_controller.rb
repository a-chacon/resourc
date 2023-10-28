class LinksController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!, only: [:create]

  # GET /links or /links.json
  def index
    @page_title = t('meta_title')
    @page_description = t('meta_description')

    @popular_tags = Tag.select('tags.*, COUNT(links_tags.link_id) AS link_count')
                       .joins(:links)
                       .group('tags.id')
                       .order('link_count DESC')
                       .limit(20)

    @q = Link.ransack(params[:q])
    @pagy, @records = pagy(@q.result(distinct: true).order(id: :desc).includes(:user, :tags))
  end

  # GET /links/new
  def new
    redirect_to root_path, alert: t('links.new.unauthorized') if session[:user_id].nil?

    @link = Link.new
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    @link.user = @current_user
    begin
      @link.tags << params[:tags].uniq.map { |t| Tag.find_or_create_by(name: t.downcase) }
    rescue StandardError
      Rails.logger.debug 'Error adding tags'
    end

    respond_to do |format|
      if @link.save
        format.html { redirect_to root_path, notice: t('links.create.successfully') }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
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

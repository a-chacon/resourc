class LinksController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!, only: [:create]

  # GET /links or /links.json
  def index
    @pagy, @records = pagy(Link.order(id: :desc).includes(:user))
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.fetch(:link, {}).permit(:title, :description, :link)
  end
end

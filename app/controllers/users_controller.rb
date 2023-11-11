class UsersController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!, except: %w[new create show]
  before_action :authorize, only: [:show]
  before_action :set_user, only: ['show']

  # GET /users or /users.json
  # def index
  # @users = User.all
  # end

  # GET /users/1 or /users/1.json
  def show
    @pagy, @records = pagy(Link.joins(:user_links).where(user_links: { user_id: User.find(params[:id]).id,
                                                                       relationship_type: :owner }).order(id: :desc))

    return unless @current_user

    @current_user_reactions = @current_user.user_links.where(relationship_type: %i[like
                                                                                   dislike]).where(link_id: @records.pluck(:id))
  end

  # GET /users/new
  def new
    @current_user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Usuario creado correctamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @current_user.update(user_params)
      redirect_back(fallback_location: root_path, notice: t('users.update.successfully'))
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    session.delete(:user_id)
    @current_user.destroy

    redirect_to root_path, alert: t('users.delete.successfully')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.fetch(:user, {}).permit(:name, :nickname, :email, :password)
  end
end

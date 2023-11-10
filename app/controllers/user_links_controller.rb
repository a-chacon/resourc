class UserLinksController < ApplicationController
  include AuthorizationConcern

  before_action :authorize!

  def create
    user_link = UserLink.new(user_links_params)
    user_link.user = @current_user

    UserLink.where(relationship_type: %i[like dislike], user: @current_user, link_id: user_link.link_id).destroy_all

    if user_link.save
      render json: { user_link:, link: user_link.link }
    else
      render json: { errors: user_link.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @current_link = @current_user.user_links.find(params[:id])
    @link = @current_link.link
    @current_link.destroy
    @link.reload
    render json: { link: @link }
  end

  private

  # Only allow a list of trusted parameters through.
  def user_links_params
    params.fetch(:user_link, {}).permit(:link_id, :relationship_type)
  end
end

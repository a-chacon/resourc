module AuthorizationConcern
  extend ActiveSupport::Concern

  def authorize!
    return render json: { error: 'Unauthorized' } if session[:user_id].nil? && User.exists?(id: session[:user_id])

    @current_user = User.find(session[:user_id])
  end
end

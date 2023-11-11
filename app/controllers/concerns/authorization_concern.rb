module AuthorizationConcern
  extend ActiveSupport::Concern

  def authorize!
    if session[:user_id].nil?
      session[:redirect_params] = params
      return redirect_to new_session_path
    end
    @current_user = User.find(session[:user_id])
  end

  def authorize
    return if session[:user_id].blank?

    @current_user = User.find(session[:user_id])
  end
end

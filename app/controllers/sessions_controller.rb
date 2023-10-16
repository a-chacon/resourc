class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    if request.env['omniauth.auth'].nil?
      session_params = params.permit(:email, :password)
      @user = User.find_by(email: session_params[:email])
      if @user && @user.authenticate(session_params[:password])
        session[:user_id] = @user.id
        redirect_to root_path, notice: 'Session iniciada correctamente.'
      else
        redirect_to new_session_path, alert: 'Email/Password incorrecto'
      end
    else
      user_info = request.env['omniauth.auth']
      Rails.logger.debug user_info
      @user = User.find_or_initialize_by(email: user_info.info.email)
      case user_info.provider
      when 'github'
        @user.nickname = user_info.info.nickname
      when 'gitlab'
        @user.nickname = user_info.info.username
      end
      @user.name = user_info.info.name
      @user.meta = user_info.to_json

      @user.attach_external_avatar(user_info.info.image) if user_info.info.image && !@user.avatar.attached?

      @user.save

      Rails.logger.debug @user.errors.inspect

      # Sign in the user
      session[:user_id] = @user.id

      redirect_to root_path, notice: "¡Sesión iniciada con #{user_info.provider}!"
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url, alert: 'Cerraste session crrectamente.'
  end
end

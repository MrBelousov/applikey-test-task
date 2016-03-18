class SessionsController < ApplicationController
  skip_before_filter :correct_user

  def new
  end

  def create
    auth = request.env["omniauth.auth"]
    if auth
      sign_in_with_auth
    else
      sign_in_with_password
    end
  end

  def sign_in_with_auth
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def sign_in_with_password
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:succes] = 'Welcome!'
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def oaut_failure
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    sign_out
    redirect_to root_url
  end
end

class Api::SessionsController < Api::APIController
  skip_before_filter :restrict_access

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
    @user = User.from_omniauth(env["omniauth.auth"])
    redirect_to root_url
  end

  def sign_in_with_password
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      self.current_user = user
      render json: current_user
    else
      render json: { message: 'Invalid email/password combination', error_code: 404 }, status: 404
    end
  end

  def oaut_failure
    redirect_to root_url
  end

  def destroy
    current_user.api_keys.find_by_token(request.headers['Authorization']).update_attribute(:token, ApiKey.create)
    self.current_user = nil
    redirect_to root_url
  end
end
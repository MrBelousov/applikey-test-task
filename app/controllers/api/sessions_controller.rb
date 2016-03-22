class Api::SessionsController < Api::APIController
  skip_before_action :restrict_access, except: [:destroy]

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      self.current_user = user
      render json: current_user
    else
      render json: { message: 'Invalid email/password combination', error_code: 422 }, status: 422
    end
  end

  def destroy
    current_user.api_keys.find_by_token(request.headers['Authorization']).update_attribute(:token, ApiKey.create)
    self.current_user = nil
    redirect_to root_url
  end
end

class Api::SessionsController < Api::APIController
  skip_before_filter :restrict_access

  def new
  end

  def create
    if request.headers['Authentication-Info'].present?
      sign_in_with_auth
    else
      sign_in_with_password
    end
  end

  def sign_in_with_auth
    RestClient.get ("https://graph.facebook.com/v2.5/me?fields=id%2Cname%2Cemail&access_token=#{request.headers['Authentication-Info']}") {
        |response|
        @response = JSON.parse(response)
    }
    user = User.find_or_create_by(email: @response['email'])
    user.password = "q1wegwqetdssd2123"
    user.password_confirmation = "q1wegwqetdssd2123"
    user.save
    self.current_user = user
    render json: user
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
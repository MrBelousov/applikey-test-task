class Api::SessionsController < Api::APIController
  skip_before_action :restrict_access

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
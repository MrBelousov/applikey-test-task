class Api::UsersController < Api::APIController
  before_action :set_user, except: [:index]
  skip_before_action :restrict_access, only: [:create]

  def index
    render json: ActiveModel::ArraySerializer.new(
            User.all,
            each_serializer: UserSerializer
        )
  end

  def show
    render json: UserSerializer.new(@user).to_json
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).to_json
    else
      render json: { errors: @user.errors }
    end
  end

  def update
    @user.avatar = params[:file] if params[:file]
    if @user.update(user_params)
      render json: UserSerializer.new(@user).to_json
    else
      render json: { errors: @user.errors }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters
  def set_user
    @user = User.find(params[:id])
  end
end

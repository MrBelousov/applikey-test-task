class Api::SessionsController < Api::APIController
  skip_before_action :restrict_access

  def destroy
    self.current_user = nil
    redirect_to root_url
  end
end
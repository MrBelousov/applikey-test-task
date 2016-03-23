class Provider < ActiveRecord::Base

  enum provider_type: {
           facebook_provider: 0
       }

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
end

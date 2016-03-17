OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1671356053115777', '5c4f26a4f41a1f477ca22a666450a663'
end
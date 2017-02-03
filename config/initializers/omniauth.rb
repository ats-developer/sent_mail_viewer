#config/initalizers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, CLIENT_ID, CLIENT_SECRET, {
                             scope: ['email', 'profile', 'https://mail.google.com/'],
                             access_type: 'offline', prompt: ["consent", "select_account"]}
end
OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, ENV['INSTAGRAM_APP_ID'], ENV['INSTAGRAM_APP_SECRET'], scope: 'basic', setup: true
end
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, '1004d8cf0a784b9b9dc4ee3fa3fa3b63', '765b4db3be1c4ca2b6abdf7503fc3ec1', scope: 'basic', setup: true
end
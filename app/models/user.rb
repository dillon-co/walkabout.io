class User < ActiveRecord::Base

  class << self
    def from_omniauth(auth)
      provider = auth.provider
      uid = auth.uid
      info = auth.info.symbolize_keys!
      user = User.find_or_initialize_by(uid: uid, provider: provider)
      user.accesstoken = auth.credentials.token
      user.refreshtoken = auth.credentials.refresh_token
      user.name = info.name
      user.username = info.nickname
      user.subdomain = info.nickname
      user.avatar = info.image
      user.bio = info.bio
      user.save!
      user
    end
  end
end

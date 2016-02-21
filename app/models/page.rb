class Page < ActiveRecord::Base
	belongs_to :user
	after_save :reload_routes

  def reload_routes
    DynamicRouter.reload
  end

  def home_page_insta
    client = Instagram.client(access_token: User.first.accesstoken)
    photos = client.user_recent_media(User.first.uid, {:count => 20})
    self.images = photos
    self.save!
    self
  end
end

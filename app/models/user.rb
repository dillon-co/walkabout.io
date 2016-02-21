class User < ActiveRecord::Base

  has_many :pages
  accepts_nested_attributes_for :pages, allow_destroy: true

  def self.current_account(some_arg)
     @account = User.find_by(some_arg)
  end


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

  def self.load_pages
    User.find_each do |u|
      client = Instagram.client(access_token: u.accesstoken)

      response = client.user_recent_media
      album = [].concat(response)
      max_id = response.pagination.next_max_id

      while !(max_id.to_s.empty?) do
        response = client.user_recent_media(:max_id => max_id)
        max_id = response.pagination.next_max_id
        album.concat(response)
      end

      @album = album

      regex = /#[\w]+/
      
      u.pages.each do |page|
        @album.each do |photo|
        if photo.caption.present?
            caption = photo.caption.text.scan(regex)
            caption.each do |c|
              if c == "#"+page.name && !page.images.include?(photo.images.standard_resolution.url)
                page.images << photo.images.standard_resolution.url
                page.save!
              end
            end
          end
        end
      end
    end
  end


end

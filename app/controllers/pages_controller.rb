class PagesController < ApplicationController
  #before_action :require_account!

  def index
  end

  def show
    client = Instagram.client(access_token: @account.accesstoken)
    @photos = client.user_recent_media(@account.uid, {:count => 20})
    @bio = @account.bio
  end
end
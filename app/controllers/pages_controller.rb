class PagesController < ApplicationController
  #before_action :set_post, only: [:show]

  def index
  end

  def show
    client = Instagram.client(access_token: @account.accesstoken)
    @photos = client.user_recent_media(@account.uid, {:count => 20})
  end

  def instapage
    @page = Page.find(params[:id])
    @bio = @account.bio
  end


  def new
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to "/"
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:name, :images)
  end
end

class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    cookies[:user_id] = { value: user.id, domain: ".huffanddoback.me" }
    flash[:success] = "Hello, #{user.name}!"
    redirect_to portfolio_url(:subdomain => "#{current_user.subdomain}")
  end

  def destroy
    cookies.delete(:user_id, :domain => '.huffanddoback.me')
    flash[:success] = "See you soon!"
    redirect_to marketing_path(:subdomain => "www")
  end
  
  def auth_fail
    render text: "You've tried to authenticate via #{params[:strategy]}, but the following error occurred: #{params[:message]}", status: 500
  end
end
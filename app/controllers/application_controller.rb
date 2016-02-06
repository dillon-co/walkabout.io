class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_account

  # def require_account!
  #   redirect_to root_url(subdomain: nil) if @account.nil? 
  # end
  
  def set_account
    @account = User.find_by(subdomain: request.subdomain)
  end

  def current_user
    @current_user ||= User.find_by(id: cookies[:user_id]) if cookies[:user_id]
  end

  helper_method :current_user
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  def user
    if session[:user_id]
      user = User.find(session[:user_id])
    end
end

def authorize
  if user.nil?
    redirect_to login_url
  end
end
end

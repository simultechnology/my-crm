class ApplicationController < ActionController::Base
  protect_from_forgery

  def user
    if session[:user_id]
      begin
        user = User.find(session[:user_id])
      rescue
        redirect_to '/500.html'
      end
    end
end

def authorize
  if user.nil?
    redirect_to login_url
  end
end
end

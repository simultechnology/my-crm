# -*- coding: utf-8 -*-
class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by_name(params[:name])
      if user.password == params[:password]
        session[:user_id] = user.id
        redirect_to :controller => 'customers', :action => 'new'
      end
    else
      redirect_to login_url, :notice => "入力情報に誤りがあります。再度ご入力下さい。"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => "Logged out!"
  end

end
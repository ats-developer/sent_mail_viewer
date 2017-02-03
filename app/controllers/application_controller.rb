# This file is intended to handle current user and check token expiration.
#
# Created At: 04-Feb-2015
# Author : Atharva System
# Copyright:: Copyright (c) 2012-2015 Atharva System.

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  before_filter :set_current_user

  def check_token_expired?
    if logged_in?
      if @current_user.token_expired?
        session.delete(:user_id)
        redirect_to root_path
      end
    end
  end

  def logged_in?
    !!@current_user
  end

  def current_user
    return User.find(session[:user_id]) if session[:user_id]
    return nil
  rescue ActiveRecord::RecordNotFound => e
    return nil
  end

  private

  def set_current_user
    @current_user ||= current_user
  end
end

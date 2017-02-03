# This file is intended to handle sessions for the application.
# index: List sent messages of current user.
# create: create user authenticated by omniauth and synchronizes sent messages.
# oauth_failure: redirects user to home page when authentication fails from omniauth.
# destroy: destroy the session of a user and redirects to home page.
#
# Created At: 04-Feb-2015
# Author : Atharva System
# Copyright:: Copyright (c) 2012-2015 Atharva System.

class SessionsController < ApplicationController
  before_filter :check_token_expired?, :except => [:index]

  def index
    if logged_in?
      # @current_user.sync_sent_messages
      @sent_messages = @current_user.sent_messages.search(params[:search]).order(message_id: :desc).limit(10)
    end
  end

  def create
    user = User.create_using_omniauth(request.env['omniauth.auth'])
    flash[:success] = t(:authenticated)
    session[:user_id] = user.id
    current_user.sync_sent_messages
  rescue OAuth2::Error => e
    flash[:error] = e.message
  ensure
    redirect_to root_path
  end

  def oauth_failure
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = t(:logout)
    redirect_to(root_path)
  end
end

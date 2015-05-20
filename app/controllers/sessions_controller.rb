# -*- coding: utf-8 -*-
# セッションを扱うコントローラ
class SessionsController < ApplicationController
  before_filter :check_whether_standalone

  def create
    return head :bad_request if params[:username].blank?

    user = User.find_or_create_by(name: params[:username].to_s) { |u|
      u.set_default_preferences
    }
    session[:username] = user.name

    render json: current_preferences
  end

  def destroy
    session[:username] = @current_user = nil

    render json: current_preferences
  end
end

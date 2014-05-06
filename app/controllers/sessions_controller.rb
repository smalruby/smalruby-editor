# -*- coding: utf-8 -*-
# セッションを扱うコントローラ
class SessionsController < ApplicationController
  before_filter :check_whether_standalone

  def create
    return head :bad_request if params[:username].blank?

    session[:username] = params[:username].to_s

    render text: session[:username]
  end

  def destroy
    session[:username] = nil

    render nothing: true
  end
end

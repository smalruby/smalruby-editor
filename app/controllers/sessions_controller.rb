# -*- coding: utf-8 -*-
# セッションを扱うコントローラ
class SessionsController < ApplicationController
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

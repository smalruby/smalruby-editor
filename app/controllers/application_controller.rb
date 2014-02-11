# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :standalone?

  private

  # スタンドアローンモードかどうかを返す
  def standalone?
    return false if Rails.env == 'production'
    return true if Rails.env == 'standalone'

    if Rails.env != 'test' &&
        (ENV['SMALRUBY_EDITOR_STANDALONE_MODE'] ||
         File.exist?(Rails.root.join('tmp', 'standalone')))
      true
    else
      false
    end
  end
end

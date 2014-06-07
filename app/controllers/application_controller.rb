# -*- coding: utf-8 -*-

require 'smalruby_editor'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :standalone?, :raspberrypi?

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

  # Raspberry Piかどうかを返す
  def raspberrypi?
    SmalrubyEditor.raspberrypi?
  end

  def check_whether_standalone
    unless standalone?
      fail "#{self.class.name}##{action_name}はstandaloneモードのみの機能です"
    end
  end
end

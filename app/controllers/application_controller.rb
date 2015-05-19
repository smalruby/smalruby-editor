# -*- coding: utf-8 -*-

require 'smalruby_editor'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :standalone?, :raspberrypi?, :current_user,
                :current_preferences

  before_filter :set_locale
  before_filter :reload_preference if Rails.env.development?

  private

  # # rubocop:disable LineLength
  # http://www.xyzpub.com/en/ruby-on-rails/3.2/i18n_mehrsprachige_rails_applikation.html
  # # rubocop:enable LineLength
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first rescue nil
  end

  # ロケールの設定
  def set_locale
    I18n.locale = params[:locale] ||
      extract_locale_from_accept_language_header || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

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

  def reload_preference
    Preference.reload!
  end

  def require_auth
    if session[:username].blank?
      head :unauthorized
      return false
    end
  end

  def current_user
    @current_user ||= User.where(name: session[:username]).first
  end

  def current_preferences
    current_user.try(:preferences) || Preference.to_hash
  end
end

require File.expand_path('../boot', __FILE__)

require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

Bundler.require(:default, Rails.env) unless Rails.env == 'standalone'

module SmalrubyEditor
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    # config.i18n.default_locale = :ja
    config.colorize_logging = false
    config.filter_parameters += [:data]
  end
end

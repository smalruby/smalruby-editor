# -*- coding: utf-8 -*-

module SmalrubyEditor
  class Config < Settingslogic
    if Rails.env.test?
      source({})
      load!
      self['features'] = ['disabled_add_character_from_beginning']
    else
      path = SmalrubyEditor.home_directory.join('config', 'config.yml')
      if path.exist?
        source(path)
      else
        source({})
      end
    end
    suppress_errors(true)

    def enabled?(feature)
      features.try(:include?, feature)
    end
    module_function :enabled?
  end
end

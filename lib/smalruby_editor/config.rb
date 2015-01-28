# -*- coding: utf-8 -*-

module SmalrubyEditor
  class Config < Settingslogic
    path = SmalrubyEditor.home_directory.join('config', 'config.yml')
    if path.exist?
      source path
    else
      source({})
    end
    suppress_errors true

    def enabled?(feature)
      features.try(:include?, feature)
    end
    module_function :enabled?
  end
end

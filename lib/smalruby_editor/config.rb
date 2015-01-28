# -*- coding: utf-8 -*-

module SmalrubyEditor
  class Config < Settingslogic
    source SmalrubyEditor.home_directory.join('config.yml')
    suppress_errors true
  end
end

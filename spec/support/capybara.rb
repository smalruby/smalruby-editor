# -*- coding: utf-8 -*-

def poltergeist?
  /\Apoltergeist/ =~ Capybara.javascript_driver.to_s
end

def selenium?
  /\Aselenium/ =~ Capybara.javascript_driver.to_s
end

def windows?
  /windows|mingw|cygwin/i =~ RbConfig::CONFIG['arch']
end

def downloads_dir
  Pathname(Rails.root).join('tmp/downloads')
end

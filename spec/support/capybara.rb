# -*- coding: utf-8 -*-

def poltergeist?
  /\Apoltergeist/ =~ Capybara.javascript_driver.to_s
end

def selenium?
  /\Aselenium/ =~ Capybara.javascript_driver.to_s
end

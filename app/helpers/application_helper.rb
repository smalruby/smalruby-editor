# -*- coding: utf-8 -*-
module ApplicationHelper
  def modal_css_class
    "modal hide#{raspberrypi? ? '' : ' fade'}"
  end
end

# -*- coding: utf-8 -*-
module ApplicationHelper
  def modal_css_class
    "modal hide#{raspberrypi? ? '' : ' fade'}"
  end

  # Blocklyのメッセージのlocaleの名前を返す
  #
  # Blocklyではenがen_usであるため
  def blockly_message_locale_name
    if I18n.locale.to_s == 'en'
      'en_us'
    else
      I18n.locale
    end
  end
end

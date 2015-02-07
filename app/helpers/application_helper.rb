# -*- coding: utf-8 -*-
module ApplicationHelper
  def modal_css_class
    "modal hide#{raspberrypi? ? '' : ' fade'}"
  end

  # default locale name for Blockly messages
  def blockly_message_default_locale_name
    'en_us'
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

  # name of Toolbox
  def toolbox_name
    SmalrubyEditor::Config.toolbox_name || 'default'
  end

  # css name of Toolbox
  def toolbox_css_name
    SmalrubyEditor::Config.toolbox_css_name ||
      SmalrubyEditor::Config.toolbox_name ||
      'default'
  end
end

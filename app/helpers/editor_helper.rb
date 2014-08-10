# -*- coding: utf-8 -*-
module EditorHelper
  # ツールボックスのブロックに対して、キャラクターの入力フィールドの値を設定する
  #
  # @param [String] name 名前
  # @return [String] XML
  def toolbox_character_field(name = 'VAR')
    %(<field name="#{h name}">char1</field>).html_safe
  end

  # ツールボックスのブロックに対して、キーの入力フィールドの値を設定する
  #
  # @param [String] name 名前
  # @param [String] value キーの名前。K_SPACE、K_Aなど
  # @return [String] XML
  def toolbox_key_field(name = 'KEY', value = 'K_SPACE')
    %(<field name="#{h name}">#{h value}</field>).html_safe
  end

  # ツールボックスのブロックに対して、PINの入力フィールドの値を設定する
  #
  # @param [String] value ピン
  # @param [String] name 名前
  # @return [String] XML
  def toolbox_pin_field(value, name = 'PIN')
    %(<field name="#{h name}">#{h value}</field>).html_safe
  end

  # ツールボックスのブロックに対して、数値型の入力のブロックを設定する
  #
  # @param [String] name 入力値の名前
  # @param [Numeric] value 数値
  # @return [String] XML
  def toolbox_number_value(name, value = 0)
    <<-XML.strip_heredoc.html_safe
      <value name="#{h name}">
        <block type="math_number">
          <field name="NUM">#{h value.to_i}</field>
        </block>
      </value>
    XML
  end

  # ツールボックスのブロックに対して、テキスト型の入力のブロックを設定する
  #
  # @param [String] name 入力値の名前
  # @param [String] value 文字列
  # @return [String] XML
  def toolbox_text_value(name = 'TEXT', value = '')
    <<-XML.strip_heredoc.html_safe
      <value name="#{h name}">
        <block type="text">
          <field name="TEXT">#{h value}</field>
        </block>
      </value>
    XML
  end
end

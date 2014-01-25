# -*- coding: utf-8 -*-
module EditorHelper
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
end

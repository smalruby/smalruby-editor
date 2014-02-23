# -*- coding: utf-8 -*-
# Rubyのソースコードをブロックに変換するモジュール
module RubyToBlock
  extend ActiveSupport::Concern

  SUCCESS_DATA_MOCK = <<-EOS.strip_heredoc
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      loop do
        move(10)
        turn_if_reach_wall
      end
    end
  EOS

  SUCCESS_XML_MOCK = <<-XML.strip_heredoc
    <xml xmlns="http://www.w3.org/1999/xhtml">
      <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
      <block type="character_new" x="4" y="4">
        <field name="NAME">car1</field>
        <statement name="DO">
          <block type="events_on_start">
            <statement name="DO">
              <block type="control_loop">
                <statement name="DO">
                  <block type="motion_move" inline="true">
                    <value name="STEP">
                      <block type="math_number">
                        <field name="NUM">10</field>
                      </block>
                    </value>
                    <next>
                      <block type="motion_turn_if_reach_wall" />
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
          </block>
        </statement>
      </block>
    </xml>
  XML

  # XML形式のブロックに変換する
  def to_blocks
    fail if data == '__FAIL__'
    return SUCCESS_XML_MOCK if data == SUCCESS_DATA_MOCK

    ''
  end
end

# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, '見た目ジャンル', to_blocks: true do
  parts = <<-EOS
car1.on(:start) do
  say(message: "こんにちは！")
  self.visible = true
  self.visible = false
  vanish
end
car1.say(message: "こんにちは！")
car1.visible = true
car1.visible = false
car1.vanish
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは！</field>
              </block>
            </value>
            <next>
              <block type="looks_show">
                <next>
                  <block type="looks_hide">
                    <next>
                      <block type="looks_vanish" />
                    </next>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは！</field>
              </block>
            </value>
            <next>
              <block type="looks_show">
                <next>
                  <block type="looks_hide">
                    <next>
                      <block type="looks_vanish" />
                    </next>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </next>
      </block>
    </statement>
      XML
    end
  end
end

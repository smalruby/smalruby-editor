# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, '音ジャンル', to_blocks: true do
  parts = <<-EOS
car1.on(:start) do
  play(name: "piano_do.wav")
end
car1.play(name: "piano_do.wav")
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
          <block type="sound_play" inline="true">
            <value name="NAME">
              <block type="sound_preset_sounds">
                <field name="NAME">piano_do.wav</field>
              </block>
            </value>
          </block>
        </statement>
        <next>
          <block type="sound_play" inline="true">
            <value name="NAME">
              <block type="sound_preset_sounds">
                <field name="NAME">piano_do.wav</field>
              </block>
            </value>
          </block>
        </next>
      </block>
    </statement>
      XML
    end
  end
end

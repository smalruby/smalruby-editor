# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, 'NeoPixel blocks', to_blocks: true do
  parts = <<-EOS
require "smalruby"

init_hardware

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  neo_pixel("D5").set(color: [0, 128, 255])
end
car1.neo_pixel("D5").set(color: [0, 128, 255])
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="hardware_neo_pixel_set_rgb">
            <field name="PIN">D5</field>
            <value name="RED">
              <block type="math_number">
                <field name="NUM">0</field>
              </block>
            </value>
            <value name="GREEN">
              <block type="math_number">
                <field name="NUM">128</field>
              </block>
            </value>
            <value name="BLUE">
              <block type="math_number">
                <field name="NUM">255</field>
              </block>
            </value>
          </block>
        </statement>
        <next>
          <block type="hardware_neo_pixel_set_rgb">
            <field name="PIN">D5</field>
            <value name="RED">
              <block type="math_number">
                <field name="NUM">0</field>
              </block>
            </value>
            <value name="GREEN">
              <block type="math_number">
                <field name="NUM">128</field>
              </block>
            </value>
            <value name="BLUE">
              <block type="math_number">
                <field name="NUM">255</field>
              </block>
            </value>
          </block>
        </next>
      </block>
    </statement>
  </block>
      XML
    end
  end
end

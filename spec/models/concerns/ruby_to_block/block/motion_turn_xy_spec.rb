# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::MotionTurnXy, to_blocks: true do
  _parts = <<-EOS
turn_x
turn_y
  EOS
  describe compact_source_code(_parts), on_start_data: true do
    __parts = _parts
    let(:parts) { __parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="motion_turn_xy">
            <field name="XY">x</field>
            <next>
              <block type="motion_turn_xy">
                <field name="XY">y</field>
              </block>
            </next>
          </block>
      XML
    end
  end

  _parts = <<-EOS
car1.turn_x
car1.turn_y
  EOS
  describe compact_source_code(_parts), character_new_data: true do
    __parts = _parts
    let(:parts) { __parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="motion_turn_xy">
        <field name="XY">x</field>
        <next>
          <block type="motion_turn_xy">
            <field name="XY">y</field>
          </block>
        </next>
      </block>
    </statement>
      XML
    end
  end

  _parts = <<-EOS
turn_x
turn_y
  EOS
  describe compact_source_code(_parts) do
    __parts = _parts
    let(:data) { __parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">turn_x</field>
    <next>
      <block type="ruby_statement">
        <field name="STATEMENT">turn_y</field>
      </block>
    </next>
  </block>
      XML
    end
  end
end

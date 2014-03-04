# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::MotionMove, to_blocks: true do
  parts = <<-EOS
move(6)
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="motion_move" inline="true">
            <value name="STEP">
              <block type="math_number">
                <field name="NUM">6</field>
              </block>
            </value>
          </block>
      XML
    end
  end

  parts = <<-EOS
car1.move(6)
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
      <block type="motion_move" inline="true">
        <value name="STEP">
          <block type="math_number">
            <field name="NUM">6</field>
          </block>
        </value>
      </block>
      XML
    end
  end

  parts = <<-EOS
move(6)
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">move(6)</field>
  </block>
      XML
    end
  end
end

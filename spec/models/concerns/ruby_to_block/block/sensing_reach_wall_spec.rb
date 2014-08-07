# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::SensingReachWall, to_blocks: true do
  parts = <<-EOS
if reach_wall?

end
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="control_if" inline="true">
            <value name="COND">
              <block type="sensing_reach_wall" />
            </value>
          </block>
      XML
    end
  end

  parts = <<-EOS
if car1.reach_wall?

end
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
      <block type="ruby_expression">
        <field name="EXP">car1.reach_wall?</field>
      </block>
      XML
    end
  end

  parts = <<-EOS
if reach_wall?

end
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="control_if" inline="true">
    <value name="COND">
      <block type="ruby_expression">
        <field name="EXP">reach_wall?</field>
      </block>
    </value>
  </block>
      XML
    end
  end
end

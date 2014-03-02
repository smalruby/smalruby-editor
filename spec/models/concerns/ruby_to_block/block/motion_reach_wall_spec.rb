# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::MotionReachWall, to_blocks: true do
  _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  if reach_wall?

  end
end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="control_if" inline="true">
            <value name="COND">
              <block type="motion_reach_wall" />
            </value>
          </block>
        </statement>
      </block>
    </statement>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
if reach_wall?

end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="control_if" inline="true">
    <value name="COND">
      <block type="motion_reach_wall" />
    </value>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
reach_wall?
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="ruby_statement">
    <field name="STATEMENT">reach_wall?</field>
  </block>
</xml>
      XML
    end
  end
end

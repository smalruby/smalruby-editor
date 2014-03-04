# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::ControlIf,
         RubyToBlock::Block::OperatorsTrue,
         RubyToBlock::Block::OperatorsFalse,
         to_blocks: true do
  _data = <<-EOS
if true

end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="control_if" inline="true">
    <value name="COND">
      <block type="operators_true" />
    </value>
  </block>
      XML
    end
  end

  _data = <<-EOS
if false

end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="control_if" inline="true">
    <value name="COND">
      <block type="operators_false" />
    </value>
  </block>
      XML
    end
  end

  _data = <<-EOS
if true
  puts "Hello, World!"
end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="control_if" inline="true">
    <value name="COND">
      <block type="operators_true" />
    </value>
    <statement name="THEN">
      <block type="ruby_statement">
        <field name="STATEMENT">puts &quot;Hello, World!&quot;</field>
      </block>
    </statement>
  </block>
      XML
    end
  end
end

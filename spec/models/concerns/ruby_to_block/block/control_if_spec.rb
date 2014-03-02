# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::ControlIf, to_blocks: true do
  _data = <<-EOS.strip_heredoc
if true

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
      <block type="operators_true" />
    </value>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
if false

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
      <block type="operators_false" />
    </value>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
if true
  puts "Hello, World!"
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
      <block type="operators_true" />
    </value>
    <statement name="THEN">
      <block type="ruby_statement">
        <field name="STATEMENT">puts &quot;Hello, World!&quot;</field>
      </block>
    </statement>
  </block>
</xml>
      XML
    end
  end
end

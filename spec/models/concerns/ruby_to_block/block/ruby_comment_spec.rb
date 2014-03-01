# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::RubyComment, to_blocks: true do
  _data = <<-EOS.strip_heredoc
# 逃げる車
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="ruby_comment">
    <field name="COMMENT">逃げる車</field>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
#   逃げる車
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="ruby_comment">
    <field name="COMMENT">  逃げる車</field>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
#逃げる車
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="ruby_statement">
    <field name="STATEMENT">#逃げる車</field>
  </block>
</xml>
      XML
    end
  end
end

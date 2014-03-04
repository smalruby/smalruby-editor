# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::RubyComment, to_blocks: true do
  _data = <<-EOS
# 逃げる車
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_comment">
    <field name="COMMENT">逃げる車</field>
  </block>
      XML
    end
  end

  _data = <<-EOS
#   逃げる車
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_comment">
    <field name="COMMENT">  逃げる車</field>
  </block>
      XML
    end
  end

  _data = <<-EOS
#逃げる車
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">#逃げる車</field>
  </block>
      XML
    end
  end
end

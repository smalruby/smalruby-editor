# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::Text, to_blocks: true do
  parts = <<-EOS
require "smalruby"

p("こんにちは")
p("\\"\\"")
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_p" inline="true">
    <value name="ARG">
      <block type="text">
        <field name="TEXT">こんにちは</field>
      </block>
    </value>
    <next>
      <block type="ruby_p" inline="true">
        <value name="ARG">
          <block type="text">
            <field name="TEXT">&quot;&quot;</field>
          </block>
        </value>
      </block>
    </next>
  </block>
      XML
    end
  end
end

# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::LooksSay, to_blocks: true do
  parts = <<-EOS
say(message: "こんにちは")
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは</field>
              </block>
            </value>
          </block>
      XML
    end
  end

  parts = <<-EOS
car1.say(message: "こんにちは")
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
      <block type="looks_say" inline="true">
        <value name="TEXT">
          <block type="text">
            <field name="TEXT">こんにちは</field>
          </block>
        </value>
      </block>
      XML
    end
  end

  parts = <<-EOS
say(message: "こんにちは")
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">say(message: &quot;こんにちは&quot;)</field>
  </block>
      XML
    end
  end

  parts = <<-EOS
self.say(message: "こんにちは")
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">self.say(message: &quot;こんにちは&quot;)</field>
  </block>
      XML
    end
  end
end

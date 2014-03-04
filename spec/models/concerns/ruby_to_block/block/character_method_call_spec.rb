# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# ここではCharacterMethodCallのexamplesとしてlooks_sayブロックを利用
# します。そのかわりlooks_sayのようにCharacterMethodCallを継承したブ
# ロックでは最低限のexamplesしか実装しません。

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::CharacterMethodCall, to_blocks: true do
  parts = <<-EOS.strip_heredoc
say(message: "こんにちは")
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should include(<<-XML)
        <statement name="DO">
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは</field>
              </block>
            </value>
          </block>
        </statement>
      XML
    end
  end

  parts = <<-EOS.strip_heredoc
say(message: "こんにちは")
puts "Hello, World!"
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should include(<<-XML)
        <statement name="DO">
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは</field>
              </block>
            </value>
            <next>
              <block type="ruby_statement">
                <field name="STATEMENT">puts &quot;Hello, World!&quot;</field>
              </block>
            </next>
          </block>
        </statement>
      XML
    end
  end

  parts = <<-EOS.strip_heredoc
car1.say(message: "こんにちは")
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should include(<<-XML)
    <statement name="DO">
      <block type="looks_say" inline="true">
        <value name="TEXT">
          <block type="text">
            <field name="TEXT">こんにちは</field>
          </block>
        </value>
      </block>
    </statement>
      XML
    end
  end

  parts = <<-EOS.strip_heredoc
car1.say(message: "こんにちは")
car1.say(message: "こんにちは")
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should include(<<-XML)
    <statement name="DO">
      <block type="looks_say" inline="true">
        <value name="TEXT">
          <block type="text">
            <field name="TEXT">こんにちは</field>
          </block>
        </value>
        <next>
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは</field>
              </block>
            </value>
          </block>
        </next>
      </block>
    </statement>
      XML
    end
  end

  parts = <<-EOS.strip_heredoc
car1.say(message: "こんにちは")
unknown.say(message: "こんにちは")
say(message: "こんにちは")
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should include(<<-XML)
    <statement name="DO">
      <block type="looks_say" inline="true">
        <value name="TEXT">
          <block type="text">
            <field name="TEXT">こんにちは</field>
          </block>
        </value>
      </block>
    </statement>
    <next>
      <block type="ruby_statement">
        <field name="STATEMENT">unknown.say(message: &quot;こんにちは&quot;)</field>
        <next>
          <block type="ruby_statement">
            <field name="STATEMENT">say(message: &quot;こんにちは&quot;)</field>
          </block>
        </next>
      </block>
    </next>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
say(message: "こんにちは")
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should include(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">say(message: &quot;こんにちは&quot;)</field>
  </block>
      XML
    end
  end
end

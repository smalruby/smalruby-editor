# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::LooksSay, to_blocks: true do
  _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  say(message: "こんにちは")
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
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">こんにちは</field>
              </block>
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
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  say(message: "こんにちは")
  puts "Hello, World!"
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
      </block>
    </statement>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
car1.say(message: "こんにちは")
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
      <block type="looks_say" inline="true">
        <value name="TEXT">
          <block type="text">
            <field name="TEXT">こんにちは</field>
          </block>
        </value>
      </block>
    </statement>
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
car1.say(message: "こんにちは")
car1.say(message: "こんにちは")
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
  </block>
</xml>
      XML
    end
  end

  _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
car1.say(message: "こんにちは")
unknown.say(message: "こんにちは")
say(message: "こんにちは")
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
  </block>
</xml>
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
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="ruby_statement">
    <field name="STATEMENT">say(message: &quot;こんにちは&quot;)</field>
  </block>
</xml>
      XML
    end
  end
end

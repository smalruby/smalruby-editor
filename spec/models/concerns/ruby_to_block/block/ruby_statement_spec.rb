# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::RubyStatement, to_blocks: true do
  _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do

  s = :a
  case s
  when :a
    puts "エー"
  when :b
    puts "ビー"
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
          <block type="ruby_statement">
            <field name="STATEMENT">s = :a</field>
            <next>
              <block type="ruby_statement">
                <field name="STATEMENT">case s</field>
                <next>
                  <block type="ruby_statement">
                    <field name="STATEMENT">when :a</field>
                    <next>
                      <block type="ruby_statement">
                        <field name="STATEMENT">  puts &quot;エー&quot;</field>
                        <next>
                          <block type="ruby_statement">
                            <field name="STATEMENT">when :b</field>
                            <next>
                              <block type="ruby_statement">
                                <field name="STATEMENT">  puts &quot;ビー&quot;</field>
                                <next>
                                  <block type="ruby_statement">
                                    <field name="STATEMENT">end</field>
                                  </block>
                                </next>
                              </block>
                            </next>
                          </block>
                        </next>
                      </block>
                    </next>
                  </block>
                </next>
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

s = :a
case s
when :a
  puts "エー"
when :b
  puts "ビー"
end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <block type="ruby_statement">
    <field name="STATEMENT">s = :a</field>
    <next>
      <block type="ruby_statement">
        <field name="STATEMENT">case s</field>
        <next>
          <block type="ruby_statement">
            <field name="STATEMENT">when :a</field>
            <next>
              <block type="ruby_statement">
                <field name="STATEMENT">  puts &quot;エー&quot;</field>
                <next>
                  <block type="ruby_statement">
                    <field name="STATEMENT">when :b</field>
                    <next>
                      <block type="ruby_statement">
                        <field name="STATEMENT">  puts &quot;ビー&quot;</field>
                        <next>
                          <block type="ruby_statement">
                            <field name="STATEMENT">end</field>
                          </block>
                        </next>
                      </block>
                    </next>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </next>
      </block>
    </next>
  </block>
</xml>
      XML
    end
  end
end

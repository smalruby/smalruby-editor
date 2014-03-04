# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::RubyStatement, to_blocks: true do
  parts = <<-EOS
s = :a
case s
when :a
  puts "エー"
when :b
  puts "ビー"
end
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
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
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

s = :a
case s
when :a
  puts "エー"
when :b
  puts "ビー"
end
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
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
      XML
    end
  end
end

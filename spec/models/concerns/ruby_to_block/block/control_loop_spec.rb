# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::ControlLoop, to_blocks: true do
  parts = <<-EOS
loop do

end
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="control_loop" />
      XML
    end
  end

  parts = <<-EOS
loop do
  puts "Hello, World!"
end
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="control_loop">
            <statement name="DO">
              <block type="ruby_statement">
                <field name="STATEMENT">puts &quot;Hello, World!&quot;</field>
              </block>
            </statement>
          </block>
      XML
    end
  end

  _data = <<-EOS
loop do

end
  EOS
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <block type="ruby_statement">
    <field name="STATEMENT">loop do</field>
    <next>
      <block type="ruby_statement">
        <field name="STATEMENT">end</field>
      </block>
    </next>
  </block>
      XML
    end
  end
end

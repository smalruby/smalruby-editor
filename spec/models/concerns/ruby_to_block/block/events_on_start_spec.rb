# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::EventsOnStart, to_blocks: true do
  parts = <<-EOS
car1.on(:start) do

end
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
      <block type="events_on_start" />
      XML
    end
  end

  parts = <<-EOS
cat1 = Character.new(costume: "costume1:cat1.png", x: 200, y: 150, angle: 90)

car1.on(:start) do

end

car1.on(:start) do

end


cat1.on(:start) do

end
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="costume1:car1.png" />
  <character name="cat1" x="200" y="150" angle="90" costumes="costume1:cat1.png" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <next>
          <block type="events_on_start" />
        </next>
      </block>
    </statement>
  </block>
  <block type="character_new">
    <field name="NAME">cat1</field>
    <statement name="DO">
      <block type="events_on_start" />
    </statement>
  </block>
      XML
    end
  end

  parts = <<-EOS
cat1 = Character.new(costume: "costume1:cat1.png", x: 200, y: 150, angle: 90)

car1.on(:start) do

  cat1.on(:start) do

  end
end
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="costume1:car1.png" />
  <character name="cat1" x="200" y="150" angle="90" costumes="costume1:cat1.png" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="character_new">
            <field name="NAME">cat1</field>
            <statement name="DO">
              <block type="events_on_start" />
            </statement>
          </block>
        </statement>
      </block>
    </statement>
  </block>
      XML
    end
  end

  parts = <<-EOS
on(:start) do

end
  EOS
  describe compact_source_code(parts), on_start_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
          <block type="events_on_start" />
      XML
    end
  end
end

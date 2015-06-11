# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::Character, to_blocks: true do
  parts = <<-EOS
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0, rotation_style: :left_right)
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" rotation_style="left_right" />
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

car1 = Character.new(costume: ["car1.png", "car2.png"], x: 0, y: 0, angle: 0)
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png,car2.png" />
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

car1 = Character.new(costume: ["car1.png", "car2.png"], costume_index: 1, x: 0, y: 0, angle: 0)
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png,car2.png" costume_index="1" />
      XML
    end
  end
end

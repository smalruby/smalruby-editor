# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block::RequireSmalruby, to_blocks: true do
  _data = 'require "smalruby"'
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it { should eq('') }
  end

  _data = '   require "smalruby"'
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it { should eq('') }
  end

  _data = 'require "smalruby"   '
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it { should eq('') }
  end

  _data = '   require   "smalruby"   '
  describe compact_source_code(_data) do
    __data = _data
    let(:data) { __data }

    it { should eq('') }
  end
end

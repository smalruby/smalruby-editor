# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'ruby_to_block/block/shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock do
  describe '#to_blocks', to_blocks: true  do
    describe '動作確認用のモックアップ' do
      context '成功する場合' do
        let(:data) { SourceCode::SUCCESS_DATA_MOCK }

        it 'XML形式のブロックを返すこと' do
          should eq(SourceCode::SUCCESS_XML_MOCK)
        end
      end

      context '失敗する場合' do
        let(:data) { '__FAIL__' }

        it { expect { subject }.to raise_error }
      end
    end
  end
end

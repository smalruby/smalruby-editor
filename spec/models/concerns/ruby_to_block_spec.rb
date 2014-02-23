# -*- coding: utf-8 -*-
require 'spec_helper'

describe RubyToBlock do
  describe '#to_blocks' do
    let(:source_code) { SourceCode.new(data: data) }

    subject { source_code.to_blocks }

    describe '通常の場合' do
      let(:data) { 'puts "Hello, World!"' }

      it { should eq('') }
    end

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

# -*- coding: utf-8 -*-
require 'spec_helper'

describe SourceCode, 'Rubyのソースコードを表現するモデル' do
  describe 'validation' do
    describe 'filename' do
      specify 'ディレクトリセパレータを含むことはできない' do
        sc = SourceCode.new(filename: '/etc/passwd')
        expect(sc).not_to be_valid
        expect(sc.errors[:filename])
          .to include('includes directory separator(s)')
      end
    end
  end

  describe '#check_syntax', 'シンタックスをチェックする' do
    let(:source_code) {
      SourceCode.new(data: data)
    }

    subject { source_code.check_syntax }

    context 'シンタックスが正しい場合' do
      let(:data) { 'puts "Hello, World!"' }

      it { should be_empty }
    end

    context 'シンタックスが正しくない場合' do
      let(:data) { 'puts Hello, World!"' }

      it { should_not be_empty }
      it {
        should include(row: 1, column: 19,
                       message: 'syntax error, unexpected tSTRING_BEG,' \
                       " expecting keyword_do or '{' or '('")
      }
      it {
        should include(row: 1, column: 0,
                       message: 'unterminated string meets end of file')
      }
    end
  end

  describe '#digest', 'プログラムのハッシュ値を計算する' do
    let(:data) { 'puts "Hello, World!"' }
    let(:source_code) {
      SourceCode.new(data: data)
    }

    subject { source_code.digest }

    it { should eq(Digest::SHA256.hexdigest(data)) }
  end

  describe '#to_blocks', 'XML形式のブロックに変換する' do
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

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
    let(:data) {
      <<-EOS.strip_heredoc
        require "smalruby"

        car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

        car1.on(:start) do
          loop do
            move(10)
            turn_if_reach_wall
          end
        end
      EOS
    }
    let(:source_code) { SourceCode.new(data: data) }

    subject { source_code.to_blocks }

    it 'XML形式のブロックを返すこと' do
      should eq(<<-XML.strip_heredoc)
        <xml xmlns="http://www.w3.org/1999/xhtml">
          <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
          <block type="character_new" x="4" y="4">
            <field name="NAME">car1</field>
            <statement name="DO">
              <block type="events_on_start">
                <statement name="DO">
                  <block type="control_loop">
                    <statement name="DO">
                      <block type="motion_move" inline="true">
                        <value name="STEP">
                          <block type="math_number">
                            <field name="NUM">10</field>
                          </block>
                        </value>
                        <next>
                          <block type="motion_turn_if_reach_wall" />
                        </next>
                      </block>
                    </statement>
                  </block>
                </statement>
              </block>
            </statement>
          </block>
        </xml>
      XML
    end
  end
end

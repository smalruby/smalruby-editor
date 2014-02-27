# -*- coding: utf-8 -*-
require 'spec_helper'

def compact_source_code(source_code)
  source_code.lines.map(&:strip).reject(&:empty?).join(';')[0...80]
end

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock do
  describe '#to_blocks' do
    let(:source_code) { SourceCode.new(data: data) }

    subject { source_code.to_blocks }

    _data = <<-EOS.strip_heredoc
require "smalruby"
    EOS
    describe compact_source_code(_data) do
      __data = _data
      let(:data) { __data }

      it { should eq('') }
    end

    _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do

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
      <block type="events_on_start" />
    </statement>
  </block>
</xml>
        XML
      end
    end

    _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
cat1 = Character.new(costume: "cat1.png", x: 200, y: 150, angle: 90)

car1.on(:start) do

end

car1.on(:start) do

end


cat1.on(:start) do

end
    EOS
    describe compact_source_code(_data) do
      __data = _data
      let(:data) { __data }

      it '結果が正しいこと' do
        should eq(<<-XML.strip_heredoc)
<xml xmlns="http://www.w3.org/1999/xhtml">
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <character name="cat1" x="200" y="150" angle="90" costumes="cat1.png" />
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
</xml>
        XML
      end
    end

    _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
cat1 = Character.new(costume: "cat1.png", x: 200, y: 150, angle: 90)

car1.on(:start) do

  cat1.on(:start) do

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
  <character name="cat1" x="200" y="150" angle="90" costumes="cat1.png" />
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
</xml>
        XML
      end
    end

    _data = <<-EOS.strip_heredoc
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do

  on(:start) do

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
          <block type="events_on_start" />
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

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do

  s = 'a'
  if s == 'a'
    puts 'エー'
  elsif s == 'b'
    puts 'ビー'
  else
    puts 'その他'
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
            <field name="STATEMENT">s = &apos;a&apos;</field>
            <next>
              <block type="ruby_statement">
                <field name="STATEMENT">if s == &apos;a&apos;</field>
                <next>
                  <block type="ruby_statement">
                    <field name="STATEMENT">  puts &apos;エー&apos;</field>
                    <next>
                      <block type="ruby_statement">
                        <field name="STATEMENT">elsif s == &apos;b&apos;</field>
                        <next>
                          <block type="ruby_statement">
                            <field name="STATEMENT">  puts &apos;ビー&apos;</field>
                            <next>
                              <block type="ruby_statement">
                                <field name="STATEMENT">else</field>
                                <next>
                                  <block type="ruby_statement">
                                    <field name="STATEMENT">  puts &apos;その他&apos;</field>
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

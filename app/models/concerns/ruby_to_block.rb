# -*- coding: utf-8 -*-

require_relative 'ruby_to_block/block'
require_relative 'ruby_to_block/context'
require_relative 'ruby_to_block/formatter'

# Rubyのソースコードをブロックに変換するモジュール
module RubyToBlock
  extend ActiveSupport::Concern

  SUCCESS_DATA_MOCK = <<-EOS.strip_heredoc
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      loop do
        move(10)
        turn_if_reach_wall
      end
    end
  EOS

  SUCCESS_XML_MOCK = <<-XML.strip_heredoc
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

  # XML形式のブロックに変換する
  def to_blocks
    fail if data == '__FAIL__'
    return SUCCESS_XML_MOCK if data == SUCCESS_DATA_MOCK

    context = Context.new(data.lines)
    while (line = context.next_line)
      line.chomp!
      next if line.strip.empty?
      md = Block.statement_regexp.match(line)
      type = context[:statement_regexp_symbols].find { |n| md[n] }
      next if Block.process_match_data(type, md, context)
      Block.process_match_data(:ruby_statement, md, context)
    end

    make_xml(context)
  end

  private

  def make_xml(context)
    return '' if context[:characters].empty? && context[:blocks].empty?

    xml = REXML::Document.new('<xml xmlns="http://www.w3.org/1999/xhtml" />',
                              attribute_quote: :quote,
                              respect_whitespace: :all)
    context[:characters].values.each do |c|
      c.to_xml(xml.root)
    end
    context[:blocks].each do |b|
      b.to_xml(xml.root)
    end

    output = StringIO.new
    formatter = Formatter.new
    formatter.write(xml, output)

    output.string + "\n"
  end
end

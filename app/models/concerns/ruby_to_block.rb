# -*- coding: utf-8 -*-

require_relative 'ruby_to_block/block'
require_relative 'ruby_to_block/context'
require_relative 'ruby_to_block/formatter'

# Rubyのソースコードをブロックに変換するモジュール
module RubyToBlock
  extend ActiveSupport::Concern

  # XML形式のブロックに変換する
  def to_blocks
    fail if data == '__FAIL__'

    context = Context.new(data.lines)
    while (line = context.next_line)
      line.chomp!
      next if line.strip.empty?
      md = Block.statement_regexp.match(line)
      next if Block.process_match_data(md, context)
      Block.process_match_data(md, context, 'ruby_statement')
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

# -*- coding: utf-8 -*-

module RubyToBlock
  # XMLをフォーマットするクラス
  #
  # REXML::Formatters::Prettyでは行頭、行末などのスペースが1つになって
  # しまうため、このクラスではそれらを修正している
  class Formatter < REXML::Formatters::Pretty
    def initialize
      super(2, true)
      self.compact = true
    end

    def write_text(node, output)
      s = node.to_s
      s.gsub!(/\s/, ' ')
      if !node.is_a?(REXML::Text) ||
          node.is_a?(REXML::Text) && !node.parent.whitespace
        s.squeeze!(' ')
      end
      s = wrap(s, @width - @level)
      s = indent_text(s, @level, ' ', true)
      output << (' ' * @level + s)
    end
  end
end

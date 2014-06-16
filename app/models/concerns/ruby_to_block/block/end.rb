# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class End < Base
      blocknize '^\s*end\s*$', statement: true

      def self.process_match_data(md, context)
        ends_num = 1
        context.lines.each do |l|
          md2 = Block.statement_regexp.match(l)
          type = md2.names.find { |n| md2[n.to_sym] }
          if type == 'end'
            ends_num += 1
          elsif Block[type].indent?
            ends_num -= 1
          end
        end
        if context.statement && ends_num <= context.statement_stack.length
          Block.process_end(context)
        else
          false
        end
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionRotateRight < Base
      blocknize '^\s*rotate\(\+?(\d+)\)\s*$', statement: true, inline: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        block = new
        context.add_block(block)

        md2 = regexp.match(md[type])
        if (value_md = Block.value_regexp.match(md2[1]))
          context.value_name_stack.push('ANGLE')
          Block.process_match_data(value_md, context)
          context.value_name_stack.pop
        end

        true
      end
    end
  end
end

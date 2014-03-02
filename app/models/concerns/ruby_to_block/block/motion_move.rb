# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionMove < Base
      blocknize '^\s*move\((.+)\)\s*$', statement: true, inline: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        block = new
        context.add_block(block)

        md2 = regexp.match(md[type])
        value_md = Block.value_regexp.match(md2[1])
        context.value_name_stack.push('STEP')
        Block.process_match_data(value_md, context)
        context.value_name_stack.pop

        true
      end
    end
  end
end

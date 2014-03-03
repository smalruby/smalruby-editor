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
        process_value_string(context, block, md2[1], 'ANGLE')

        true
      end
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionMove < Base
      blocknize '^\s*move\((.+)\)\s*$', statement: true, inline: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        context.add_block(new)

        md2 = regexp.match(md[type])
        process_value_string(context, md2[1], 'STEP')

        true
      end
    end
  end
end

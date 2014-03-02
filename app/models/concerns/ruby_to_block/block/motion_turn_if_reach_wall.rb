# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionTurnIfReachWall < Base
      blocknize '^\s*turn_if_reach_wall\s*$', statement: true

      def self.process_match_data(md, context)
        return false unless context.receiver

        context.add_block(new)

        true
      end
    end
  end
end

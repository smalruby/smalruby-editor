# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionTurnIfReachWall < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'turn_if_reach_wall\s*$', statement: true
    end
  end
end

# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionTurn < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'turn\s*$', statement: true
    end
  end
end

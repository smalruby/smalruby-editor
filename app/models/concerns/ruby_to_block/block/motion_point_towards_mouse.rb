# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionPointTowardsMouse < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'point_towards\(:mouse\)\s*$',
                statement: true
    end
  end
end

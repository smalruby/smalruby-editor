# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionGoToMouse < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'go_to\(:mouse\)\s*$',
                statement: true
    end
  end
end

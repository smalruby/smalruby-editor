# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class LooksHide < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'visible\s*=\s*false\s*$', statement: true
    end
  end
end

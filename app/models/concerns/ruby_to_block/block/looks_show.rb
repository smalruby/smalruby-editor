# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class LooksShow < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'visible\s*=\s*true\s*$', statement: true
    end
  end
end

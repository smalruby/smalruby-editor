# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class LooksVanish < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'vanish\s*$', statement: true
    end
  end
end

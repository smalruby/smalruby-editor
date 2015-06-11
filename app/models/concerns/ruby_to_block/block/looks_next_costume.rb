# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class LooksNextCostume < CharacterMethodCall
      blocknize ['^\s*',
                 CHAR_RE,
                 'next_costume',
                 '\s*$'].join(""),
                statement: true
    end
  end
end

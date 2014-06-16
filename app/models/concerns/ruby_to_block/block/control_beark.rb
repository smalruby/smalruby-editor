# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class ControlBreak < Base
      blocknize '^\s*break\s*$', statement: true, inline: true

      def self.process_match_data(md, context)
        context.add_block(new)
        true
      end
    end
  end
end

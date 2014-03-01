# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class RubyComment < Base
      blocknize '^\s*\#\ (.*)$', statement: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block = new(fields: { COMMENT: md2[1] })
        context.add_block(block)

        true
      end
    end
  end
end

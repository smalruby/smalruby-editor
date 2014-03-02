# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class Else < Base
      blocknize '^\s*else\s*$', statement: true

      def self.process_match_data(md, context)
        Block.process_else(context)
      end
    end
  end
end

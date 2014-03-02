# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MathNumber < Base
      blocknize '^\s*([+-]?\d+(?:\.\d+)?)\s*$', value: true

      def self.process_match_data(md, context)
        context.add_value(new(fields: { NUM: md[type].sub(/^\+/, '') }))

        true
      end
    end
  end
end

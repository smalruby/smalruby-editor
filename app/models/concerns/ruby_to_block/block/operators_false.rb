# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class OperatorsFalse < Base
      blocknize '^\s*false\s*$', value: true

      def self.process_match_data(md, context)
        context.add_value(new)

        true
      end
    end
  end
end

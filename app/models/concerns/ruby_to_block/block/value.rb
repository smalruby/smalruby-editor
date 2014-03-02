# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class Value < Base
      def self.process_match_data(md, context)
        context.add_value(new)

        true
      end
    end
  end
end

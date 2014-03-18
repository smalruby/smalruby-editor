# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class RubyExpression < Value
      blocknize '^.*$', value: true, priority: -Float::INFINITY

      def self.process_match_data(md, context)
        context.add_value(new(fields: { EXP: md.string }))

        true
      end
    end
  end
end

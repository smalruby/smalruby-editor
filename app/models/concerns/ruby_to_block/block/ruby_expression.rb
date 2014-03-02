# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class RubyExpression < Value
      blocknize '^.*$', value: true, priority: -Float::INFINITY

      def self.process_match_data(md, context)
        exp = md[type]
        exp = exp[1..-2] if /^\(.*\)$/.match(exp)
        context.add_value(new(fields: { EXP: exp }))

        true
      end
    end
  end
end

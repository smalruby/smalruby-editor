# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class OperatorsCompare < Value
      blocknize '^\s*(\S+?)\s*(<|<=|==|>=|>)\s*(\S+?)\s*$',
                value: true, inline: true

      OPERATOR_TO_TYPE = {
        '<' => "#{type}_lt",
        '<=' => "#{type}_lte",
        '==' => "#{type}_eq",
        '>=' => "#{type}_gte",
        '>' => "#{type}_gt",
      }

      attr_accessor :compare_type

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        block = new
        context.add_value(block)

        process_value_string(context, block, md2[1], :A)
        block.compare_type = md2[2]
        process_value_string(context, block, md2[3], :B)

        true
      end

      def type
        OPERATOR_TO_TYPE[@compare_type]
      end
    end
  end
end

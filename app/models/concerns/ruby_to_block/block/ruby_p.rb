# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class RubyP < CharacterMethodCall
      blocknize '^\s*p\((.+)\)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        block = new
        context.add_block(block)

        md2 = regexp.match(md[type])
        process_value_string(context, block, md2[1], :ARG)

        true
      end
    end
  end
end

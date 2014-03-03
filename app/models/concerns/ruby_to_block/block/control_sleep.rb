# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class ControlSleep < Base
      blocknize '^\s*sleep\((.+)\)\s*$', statement: true, inline: true

      def self.process_match_data(md, context)
        context.add_block(new)

        md2 = regexp.match(md[type])
        process_value_string(context, md2[1], 'SEC')

        true
      end
    end
  end
end

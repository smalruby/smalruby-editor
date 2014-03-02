# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class Text < Value
      blocknize '^\s*"([^"]*)"\s*$', value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        context.add_value(new(fields: { TEXT: md2[1] }))

        true
      end
    end
  end
end

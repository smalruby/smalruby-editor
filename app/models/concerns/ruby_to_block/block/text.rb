# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class Text < Value
      blocknize '^\s*"(.*)"\s*$', value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        text = md2[1].gsub(/\\"/, '"')
        context.add_value(new(fields: { TEXT: text }))

        true
      end
    end
  end
end
